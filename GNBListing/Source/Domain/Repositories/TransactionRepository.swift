//
//  TransactionRepository.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

protocol TransactionRepository {
    func getTransactions(completion: @escaping (Result<[Transaction], AppError>) -> Void)
    func getConversionRates(completion: @escaping (Result<[ConversionRate], AppError>) -> Void)
}
