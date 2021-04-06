//
//  TransactionAPI.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

struct TransactionAPI: Decodable {
    let sku: String
    let amount: String
    let currency: String
}
