//
//  Decimal+Formatter.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 6/4/21.
//

import Foundation

extension Decimal {
    func formatted(asCurrency currency: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        let doubleValue = (self as NSDecimalNumber).doubleValue
        
        return formatter.string(from: NSNumber(value: doubleValue))
    }
}
