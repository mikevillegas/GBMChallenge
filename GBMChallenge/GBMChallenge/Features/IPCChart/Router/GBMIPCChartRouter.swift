//
//  GBMIPCChartRouter.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation
import UIKit


class GBMIPCChartRouter: GBMIPCChartRouterProtocol {

    static func CreateModule() -> UIViewController {
        let viewController = GBMIPCChartVC(nibName: "GBMIPCChartVC", bundle: nil)
        var presenter: GBMIPCChartPresenterProtocol & GBMIPCChartOutputInteractorProtocol = GBMIPCChartPresenter()
        let interactor: GBMIPCChartInteractor = GBMIPCChartInteractor()
        let routing: GBMIPCChartRouter = GBMIPCChartRouter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = routing
        presenter.interactor = interactor
        interactor.presenter = presenter
        return viewController
        
    }
    func loadIPCChartView() -> UIViewController {
        return GBMIPCChartRouter.CreateModule()
    }
}



