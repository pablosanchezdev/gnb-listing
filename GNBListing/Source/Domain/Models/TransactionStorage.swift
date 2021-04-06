//
//  TransactionStorage.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

class TransactionStorage {
    private(set) var transactions: [Transaction]
    
    init() {
        self.transactions = []
    }
    
    func setTransactions(_ transactions: [Transaction]) {
        self.transactions = transactions
    }
}
