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
        return Transaction(sku: sku, amount: Double(amount)!, currency: currency)
    }
}

// MARK: - ConversionRateAPI mapper
extension ConversionRateAPI {
    func toConversionRate() -> ConversionRate {
        return ConversionRate(from: from, to: to, rate: Double(rate)!)
    }
}
