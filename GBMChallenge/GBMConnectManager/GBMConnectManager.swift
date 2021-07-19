//
//  GBMConnectManager.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 14/07/21.
//

import Foundation

/// Protocolo que se ejecuta al ser obtenida la información del servicio.
public protocol GBMConnectManagerProtocol {
    /// Función que indica que la llamada ha sido exitosa, obteniendo la información solicitada.
    /// - Parameter data: Información obtenida.
    func didReceiveData(data: Data)
    /// Función que indica que la llamada no ha sido exitosa, obteniendo el error de dicha llamada.
    /// - Parameter error: Tipo de error en la llamada.
    func didReceiveError(error: Error)
}
/// Clase para realizar llamadas a determinados servicios
class GBMConnectManager: NSObject, URLSessionDelegate {
    /// Objeto de tipo URLSession que nos ayudará a administrar la sesión.
    private var manager: URLSession?
    /// Delegado para obtener la información de la llamada.
    public var delegate: GBMConnectManagerProtocol?
    
    public  override init() {
        super.init()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 30.0
        self.manager = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    /// Función para ejecutar una consulta de servicio
    /// - Parameters:
    ///   - url: Url principal del servicio
    /// - Throws: Error que devuelve al no cumplir con alguna especificación
    public func connectWithGetRestRequest(url: String) throws {
        guard let mainURL = URL(string: url) else {
            throw GBMError.missinURL
        }
        DispatchQueue.global(qos: .userInitiated).async {
            var request = URLRequest(url: mainURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30.0)
            request.httpBody = nil
            request.httpMethod = "GET"
            self.manager?.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let info = data else {
                        self.delegate?.didReceiveError(error: GBMError.missingInformation)
                        return
                    }
                self.delegate?.didReceiveData(data: info )
            }).resume()
        }
        
    }
}
