//
//  GBMIPCChartVC.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 17/07/21.
//

import UIKit
import SwiftChart

enum DateError: String, Error {
    case invalidDate
}


class GBMIPCChartVC: UIViewController {
    var presenter: GBMIPCChartPresenterProtocol?
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var chartView: Chart!
    private var infoArray: [GBMIPCEntity] = [GBMIPCEntity]()
    private var tmpArray = [(x: Int, y: Double)]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoading(overView: self.view)
        self.showIPCInformation()
    }

}

extension GBMIPCChartVC: GBMIPCChartViewProtocol {
    func loadErrorInChart(message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Error en consulta", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
                self.stopLoading()
            }
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func showIPCInformation() {
        self.presenter?.getIPCInformation()
    }
    
    func loadInformationInChart(info: [GBMIPCEntity]) {
        var i = 0
        self.infoArray = info
        for ipc in self.infoArray {
            tmpArray.append((x: i, y: Double(ipc.price ?? 0)))
            i += 1
        }
        
        DispatchQueue.main.async {
            self.chartView.frame = CGRect.zero
            let series = ChartSeries(data: self.tmpArray)
            series.color = UIColor(named: "GBMQuaternaryColor") ?? ChartColors.purpleColor()
            self.chartView.lineWidth = 1
            self.chartView.xLabelsTextAlignment = .center
            self.chartView.yLabelsOnRightSide = false
            self.chartView.xLabelsOrientation = .vertical
            self.chartView.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
                return (self.infoArray[labelIndex].date ?? "sin información")
            }
            self.chartView.labelColor = .clear
            self.chartView.delegate = self
            self.chartView.add(series)
            self.stopLoading()
        }
    }
    
    
}

extension GBMIPCChartVC: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        
        if let index = indexes[0] {
            self.lblInformation.text = "Cambio: " + (self.infoArray[index].change?.convertMoneyString() ?? "-")
            self.lblPercent.text = "Porcentaje: " + (self.infoArray[index].percentageChange?.convertPercentString() ?? "-")
            if let date = self.infoArray[index].date {
                self.lblDate.text = "Fecha: " + (date.formatDate() ?? "-")
            }
            self.lblPrice.text = "Precio: " + (self.infoArray[index].price?.convertMoneyString() ?? "-")
    
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        self.lblInformation.text = "-"
        self.lblPercent.text = "-"
        self.lblDate.text = "-"
        self.lblPrice.text = "-"
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
}



