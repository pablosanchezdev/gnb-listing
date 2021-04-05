//
//  TransactionsRepository.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

protocol TransactionsRepository {
    func getTransactions(completion: @escaping (Result<[Transaction], AppError>) -> Void)
    func getConversionRates(completion: @escaping (Result<[ConversionRate], AppError>) -> Void)
}
