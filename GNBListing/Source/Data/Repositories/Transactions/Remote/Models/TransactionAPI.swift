//
//  TransactionAPI.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

struct TransactionAPI: Decodable {
    let sku: String
    let amount: Double
    let currency: String
}
