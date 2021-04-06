//
//  ProductDetailPresenter.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

private let kEUR = "EUR"
private let kTotalEurFormat = "El total en euros son %.2f"

protocol ProductDetailPresenterDelegate: class {
    func setupView()
    func setTotal(_ total: String)
    func render(transactions: [Transaction])
    func showError(message: String)
}

class ProductDetailPresenter: BasePresenter {
    weak var view: ProductDetailPresenterDelegate?
    
    private let index: Int
    private let transactions: [Transaction]
    private let repository: TransactionRepository
    
    init(index: Int, storage: TransactionStorage, repository: TransactionRepository) {
        self.index = index
        self.transactions = storage.transactions
        self.repository = repository
    }
    
    override func prepareView(for state: ViewState) {
        switch state {
        case .didLoad:
            view?.setupView()
        case .didAppear:
            fetchData()
        default:
            break
        }
    }
}

// MARK: - Private methods
private extension ProductDetailPresenter {
    func fetchData() {
        fetchConversions() { [weak self] conversionRates in
            guard let strongSelf = self else { return }
            
            let productTransactions = strongSelf.filterProductTransactions()
            self?.view?.render(transactions: productTransactions)
            let totalEuros = strongSelf.totalEuros(forTransactions: productTransactions,
                                                   withConversionRates: conversionRates)
            let totalEurosFormatted = String.init(format: kTotalEurFormat, totalEuros)
            self?.view?.setTotal(totalEurosFormatted)
        }
    }
    
    func fetchConversions(completionSuccess: @escaping ([ConversionRate]) -> Void) {
        repository.getConversionRates { [weak self] result in
            switch result {
            case .success(let conversionRates):
                completionSuccess(conversionRates)
            case .failure(let error):
                self?.view?.showError(message: error.description)
            }
        }
    }
    
    func filterProductTransactions() -> [Transaction] {
        let transactionSelected = transactions[index]
        let filteredTransactions = transactions.filter { $0.sku == transactionSelected.sku }
        
        return filteredTransactions
    }
    
    func totalEuros(forTransactions transactions: [Transaction], withConversionRates rates: [ConversionRate]) -> Double {
        let totalEuros = transactions.reduce(0.0) { (accum, transaction) -> Double in
            if transaction.currency == kEUR {
                return accum + transaction.amount
            } else {
                return accum + convertAmount(fromTransaction: transaction, toEurosWithConversionRates: rates)
            }
        }
        
        return totalEuros
    }
    
    func convertAmount(fromTransaction transaction: Transaction, toEurosWithConversionRates rates: [ConversionRate]) -> Double {
        let currency = transaction.currency
        // Get currency conversion rates
        let currencyConversionRates = rates.filter { $0.from == currency }
        // Check if direct conversion to EUR exists
        let directConversion = currencyConversionRates.first { $0.to == kEUR }
        if let directConversion = directConversion {
            return directConversion.rate * transaction.amount
        } else { // Direct conversion to EUR is not available
            for rate in currencyConversionRates {
                let originRate = rate.rate
                let targetCurrency = rate.to
                let targetConversion = rates.first { $0.from == targetCurrency && $0.to == kEUR }
                if let targetConversion = targetConversion {
                    return targetConversion.rate * originRate * transaction.amount
                }
            }
            
            // No possible conversion
            return 0.0
        }
    }
}
