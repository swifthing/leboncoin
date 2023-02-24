//
//  Double+Extension.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import Foundation

extension Double {
    var currency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
