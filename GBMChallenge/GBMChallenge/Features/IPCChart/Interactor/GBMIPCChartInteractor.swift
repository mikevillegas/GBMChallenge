//
//  GBMIPCChartInteractor.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation


class GBMIPCChartInteractor:  GBMIPCChartInteractorProtocol {
    var presenter: GBMIPCChartOutputInteractorProtocol?
    private var connectMG: GBMConnectManager = GBMConnectManager()

    func requestIPCInfoFromApi() {
        do {
            self.connectMG.delegate = self
            try self.connectMG.connectWithGetRestRequest(url: "https://run.mocky.io/v3/cc4c350b-1f11-42a0-a1aa-f8593eafeb1e")
        } catch  {
            print("error")
        }
    }
    
}



extension GBMIPCChartInteractor: GBMConnectManagerProtocol {
    func didReceiveData(data: Data) {
        let jsonDecoder = JSONDecoder()
        let infoArray = try! jsonDecoder.decode([GBMIPCEntity].self, from: data)
        self.presenter?.successIPCInfo(data: infoArray)
    }
    
    func didReceiveError(error: Error) {
        print(error.localizedDescription)
        self.presenter?.errorIPCInfo(error: GBMError.missingInformation)

    }
}
