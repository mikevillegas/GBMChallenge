//
//  GBMError.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 14/07/21.
//

import Foundation

public enum GBMError: String, Error {
    case missinURL
    case missingInformation
    case dateConversion
}
extension GBMError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .missinURL:
            return NSLocalizedString("Es necesaria la url para continuar", comment: "URL no especificada")
        case .missingInformation:
            return NSLocalizedString("No se ha podido traer la información", comment: "Información no encontrada")
        case .dateConversion:
            return NSLocalizedString("No se ha podido convertir la fecha", comment: "Error en fecha")
        }
    }
}
