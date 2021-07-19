//
//  Float.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import Foundation

extension Double {
    func convertMoneyString() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "es_MX")
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
    func convertPercentString() -> String {
        let formatted = String(format: "%.2f", self)
        return "\(formatted)%"
    }
}
