//
//  GBMLoginVC.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 17/07/21.
//

import UIKit
import LocalAuthentication


/// Clase que contiene la lógica de la vista
class GBMLoginVC: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    var routerIPCChart: GBMIPCChartRouter  = GBMIPCChartRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
 }

    @IBAction func loginUser(_ sender: Any) {
        let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Accede con este  método de autenticación."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            self?.showHomeViewController()
                        } else {
                            let ac = UIAlertController(title: "Error de autenticación", message: "La autenticación no fue satisfactoria; intenta de nuevo.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "Aceptar", style: .default))
                            self?.present(ac, animated: true)
                        }
                    }
                }
            } else {
                // no biometry
                let ac = UIAlertController(title: "Autenticación Biométrica no disponible", message: "La autenticación biométrica no está disponible en este dispositivo.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(ac, animated: true)
            }
        
    }
    
    func showHomeViewController() {
        var viewControllers = [UIViewController]()
        let chartViewController = self.routerIPCChart.loadIPCChartView()
        chartViewController.tabBarItem.title = "Chart"
        chartViewController.tabBarItem.image = UIImage(named: "ChartTab")
        let ipcDetail = GBMIPCDetailListVC()
        ipcDetail.tabBarItem.title = "Detalle"
        ipcDetail.tabBarItem.image = UIImage(named: "DetailTab")
        viewControllers.append(chartViewController)
        viewControllers.append(ipcDetail)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
            /// Creación del tabBarController
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = viewControllers
            tabBarController.tabBar.tintColor = UIColor(named: "GBMQuinary")
            tabBarController.tabBar.unselectedItemTintColor = UIColor(named: "GBMSecondaryColor")
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionCrossDissolve],
                              animations: {
                                window.rootViewController = tabBarController
                                window.makeKeyAndVisible()
            },
              completion: { finished in
                if finished {
                    if  let navigationController = tabBarController.selectedViewController as? UINavigationController {
                        if navigationController.viewControllers.first != nil {
                            //Cargar configuraciones de la app
                        }
                    }
                }
            })
        }
    }

}
