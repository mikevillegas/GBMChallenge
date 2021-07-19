//
//  GBMIPCDetailListVC.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 17/07/21.
//

import UIKit

class GBMIPCDetailListVC: UIViewController {
    private var infoArray: [GBMIPCEntity] =  [GBMIPCEntity]()
    private let ipcDetailCellId = "IPCDetailCell"
    private let connection = GBMConnectManager()

    @IBOutlet var tblIPCDetail: UITableView!
    var apiTimer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblIPCDetail.delegate = self
        self.tblIPCDetail.dataSource = self
        self.tblIPCDetail.register(UINib(nibName: "GBMIPCCellTableViewCell", bundle: nil), forCellReuseIdentifier: ipcDetailCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getIPCinfo()
        self.apiTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getIPCinfo), userInfo: nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.apiTimer?.invalidate()
    }
    /// Función para obtener la información del IPC
    @objc func getIPCinfo()  {
        do {
            self.startLoading(overView: self.view)
            self.connection.delegate = self
            try self.connection.connectWithGetRestRequest(url: "https://run.mocky.io/v3/cc4c350b-1f11-42a0-a1aa-f8593eafeb1e")
        } catch  {
            print("error")
        }
    }

}

extension GBMIPCDetailListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblIPCDetail.dequeueReusableCell(withIdentifier: ipcDetailCellId, for: indexPath) as? GBMIPCCellTableViewCell  else {
            return UITableViewCell()
        }

        let ipcEntity: GBMIPCEntity = self.infoArray[indexPath.row]
        cell.lblIPCPrice.text =   "Precio: " +  (ipcEntity.price?.convertMoneyString() ?? "-")
        cell.lblIPCDate.text =    "Fecha: " + (ipcEntity.date?.formatDate() ?? "-")
        cell.lblIPCVolume.text =  "Volúmen: " + String(ipcEntity.volume ?? 0)
        cell.lblIPCChange.text =  "Cambio: " + (ipcEntity.change?.convertMoneyString() ?? "-")
        cell.lblIPCPercent.text = "Porcentaje: " + (ipcEntity.percentageChange?.convertPercentString() ?? "-")
      return cell
    
    }
}

extension GBMIPCDetailListVC: GBMConnectManagerProtocol {
    func didReceiveData(data: Data) {
        let jsonDecoder = JSONDecoder()
        self.infoArray = try! jsonDecoder.decode([GBMIPCEntity].self, from: data)
        DispatchQueue.main.async {
            self.tblIPCDetail.reloadData()
            self.stopLoading()
        }
    }
    
    func didReceiveError(error: Error) {
        print(error.localizedDescription)
        self.stopLoading()
    }
}
