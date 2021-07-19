//
//  String.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation


extension String {
    func formatDate() -> String? {
        var stringDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
            stringDate = dateFormatter.string(from: date)
        }
        return stringDate
    }
    
    var percentage: String {
        let double = self.toDouble() ?? 0.0
        let formatted = String(format: "%.2f", double)
        return "\(formatted)%"
    }
    
    
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        return formatter.number(from: self)?.doubleValue
    }
    
    /// Añade signo de pesos.
    var signalDollar: String {
        return "$\(self)"
    }
    
    /// Función que decodifica un string en base 64.
    /// - Returns: Valor decodificado.
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    /// Función que codifica un string en base 64.
    /// - Returns: Valor codificado.
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
}
