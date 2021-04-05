//
//  TransactionEndpoints.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

enum TransactionEndpoints {
    case getConversionRates
    case getTransactions
    
    var baseUrl: String {
        guard let url = Constants.transactionsBaseURL else { fatalError("TransactionsBaseURL must be specified") }
        return url
    }
}

// MARK: - Endpoint
extension TransactionEndpoints: Endpoint {
    var httpMethod: HttpMethod {
        switch self {
        case .getConversionRates, .getTransactions:
            return .get
        }
    }
    
    var path: String {
        guard let baseUrl = Constants.transactionsBaseURL else {
            fatalError("TransactionsBaseURL must be specified")
        }
        switch self {
        case .getConversionRates:
            return "\(baseUrl)/\(Constants.conversionRatesPath)"
        case .getTransactions:
            return "\(baseUrl)/\(Constants.transactionsPath)"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getConversionRates, .getTransactions:
            return ["Accept": "application/json"]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getConversionRates, .getTransactions:
            return nil
        }
    }
}
