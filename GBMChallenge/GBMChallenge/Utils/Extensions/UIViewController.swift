//
//  ViewController.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 17/07/21.
//

import UIKit
import Lottie

var loading : UIView?

extension UIViewController {
    /// Función para cargar el loading
    /// - Parameter overView: vista donde se pondrá la vista de loading
    func startLoading(overView : UIView) {
        let containerView = UIView.init()
        containerView.backgroundColor = UIColor(named: "GBMPrimaryColor")
        let animationView = AnimationView(name: "GBMInvestmentAnimation")
        animationView.loopMode = .loop
        animationView.animationSpeed = 3.0
        animationView.play()
        DispatchQueue.main.async {
            overView.addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = containerView.centerXAnchor.constraint(equalTo: overView.centerXAnchor)
            let verticalConstraint = containerView.centerYAnchor.constraint(equalTo: overView.centerYAnchor)
            let widthConstraint = containerView.widthAnchor.constraint(equalToConstant: overView.bounds.width)
            let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: overView.bounds.height)
            overView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
            
            containerView.addSubview(animationView)
            animationView.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint2 = animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            let verticalConstraint2 = animationView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            let widthConstraint2 = animationView.widthAnchor.constraint(equalToConstant: 200)
            let heightConstraint2 = animationView.heightAnchor.constraint(equalToConstant: 200)
            containerView.addConstraints([horizontalConstraint2, verticalConstraint2, widthConstraint2, heightConstraint2])
        }
        loading = containerView
    }
    /// Función para detener el loading
    func stopLoading() {
        DispatchQueue.main.async {
            loading?.removeFromSuperview()
            loading = nil
        }
    }
}

