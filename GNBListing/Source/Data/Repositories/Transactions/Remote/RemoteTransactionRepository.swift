//
//  RemoteTransactionRepository.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

struct RemoteTransactionRepository: TransactionRepository {
    let apiClient: APIClient
    let decoder: Decoder
    
    func getTransactions(completion: @escaping (Result<[Transaction], AppError>) -> Void) {
        let endpoint = TransactionEndpoints.getTransactions
        apiClient.makeRequest(to: endpoint) { result in
            switch result {
            case .success(let json):
                do {
                    let rawTransactions = try decoder.decode(json, as: [TransactionAPI].self)
                    let transactions = rawTransactions.map { $0.toTransaction() }
                    completion(.success(transactions))
                } catch {
                    completion(.failure(error as! AppError))
                }
            case .failure(_):
                completion(.failure(.apiRequest))
            }
        }
    }
    
    func getConversionRates(completion: @escaping (Result<[ConversionRate], AppError>) -> Void) {
        let endpoint = TransactionEndpoints.getConversionRates
        apiClient.makeRequest(to: endpoint) { result in
            switch result {
            case .success(let json):
                do {
                    let rawConversionRates = try decoder.decode(json, as: [ConversionRateAPI].self)
                    let conversionRates = rawConversionRates.map { $0.toConversionRate() }
                    completion(.success(conversionRates))
                } catch {
                    completion(.failure(error as! AppError))
                }
            case .failure(_):
                completion(.failure(.apiRequest))
            }
        }
    }
}
