//
//  GBMIPCChartProtocol.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation
import UIKit
/// Protocolo para conectar Presenter-View
protocol GBMIPCChartViewProtocol {
    var presenter: GBMIPCChartPresenterProtocol? { get set }
    /// Obtener información del IPC
    func showIPCInformation()
    /// Carga la información en la gráfica
    /// - Parameter info: Entidad que contiene la información
    func loadInformationInChart(info: [GBMIPCEntity])
    /// Función para mostrar error
    /// - Parameter error: string con el mensaje  de  error
    func loadErrorInChart(message: String)
}
/// Protocolo para conectar View-Presenter
protocol GBMIPCChartPresenterProtocol {
    var router: GBMIPCChartRouterProtocol?{get set}
    var view: GBMIPCChartViewProtocol? {get set}
    var interactor: GBMIPCChartInteractorProtocol? {get set}
    /// Función para obtener la información
    func getIPCInformation()
    /// Función para presentar la información hacia el usuario
    /// - Parameter info: Objeto que contiene la información del IPC
    func prepareIPCInformation(info: [GBMIPCEntity])
    
}
/// Protocolo para conectar Presenter-Interactor
protocol GBMIPCChartInteractorProtocol {
    var presenter: GBMIPCChartOutputInteractorProtocol? {get set}
    /// Función para realizar la petición hacia el connection manager
    func requestIPCInfoFromApi()
}
/// Protocolo para conectar Interactor-Presenter
protocol GBMIPCChartOutputInteractorProtocol {
    /// Respuesta exitosa de la consulta
    /// - Parameter data: Objeto que contiene la info para la gráfica
   func successIPCInfo(data: [GBMIPCEntity])
    
    /// Respuesta con error en la consulta
    /// - Parameter error: Objeto con el error ocurrido
    func errorIPCInfo(error: GBMError)
}


/// Protocolo para conectar Presenter-Router
protocol GBMIPCChartRouterProtocol {
    //Presenter-Routing
    func loadIPCChartView() -> UIViewController
}
