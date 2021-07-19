//
//  GBMIPCChartPresenter.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation


class GBMIPCChartPresenter: GBMIPCChartPresenterProtocol {
    var interactor: GBMIPCChartInteractorProtocol?
    var router: GBMIPCChartRouterProtocol?
    var view: GBMIPCChartViewProtocol?
    func getIPCInformation() {
        self.interactor?.requestIPCInfoFromApi()
    }
    func prepareIPCInformation(info: [GBMIPCEntity]) {
        
    }
    
    
}

extension GBMIPCChartPresenter: GBMIPCChartOutputInteractorProtocol {
    func successIPCInfo(data: [GBMIPCEntity]) {
        self.view?.loadInformationInChart(info: data)
    }
    func errorIPCInfo(error: GBMError) {
        self.view?.loadErrorInChart(message: error.localizedDescription)
    }
}
