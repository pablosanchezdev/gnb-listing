//
//  TransactionMapper.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

// MARK: - TransactionAPI mapper
extension TransactionAPI {
    func toTransaction() -> Transaction {
        if let amount = Decimal(string: amount) {
            return Transaction(sku: sku, amount: amount, currency: currency)
        } else {
            return Transaction(sku: sku, amount: Decimal(0), currency: currency)
        }
    }
}

// MARK: - ConversionRateAPI mapper
extension ConversionRateAPI {
    func toConversionRate() -> ConversionRate {
        return ConversionRate(from: from, to: to, rate: Double(rate)!)
    }
}
