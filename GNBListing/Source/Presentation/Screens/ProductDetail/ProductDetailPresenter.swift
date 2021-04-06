//
//  ProductDetailPresenter.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

private let kEUR = "EUR"
private let kTotalEurFormat = "El total en euros son %@"

protocol ProductDetailPresenterDelegate: class {
    func setupView()
    func setTotal(_ total: String)
    func render(transactions: [Transaction])
}

class ProductDetailPresenter: BasePresenter {
    weak var view: ProductDetailPresenterDelegate?
    
    private let index: Int
    private let transactions: [Transaction]
    private let coordinator: ProductDetailCoordinatorProtocol
    private let repository: TransactionRepository
    
    init(index: Int,
         storage: TransactionStorage,
         coordinator: ProductDetailCoordinatorProtocol,
         repository: TransactionRepository) {
        self.index = index
        self.transactions = storage.transactions
        self.coordinator = coordinator
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
            let totalEurosFormatted = String(format: kTotalEurFormat, totalEuros.formatted(asCurrency: "EUR")!)
            self?.view?.setTotal(totalEurosFormatted)
        }
    }
    
    func fetchConversions(completionSuccess: @escaping ([ConversionRate]) -> Void) {
        repository.getConversionRates { [weak self] result in
            switch result {
            case .success(let conversionRates):
                completionSuccess(conversionRates)
            case .failure(let error):
                self?.coordinator.showError(message: error.description)
            }
        }
    }
    
    func filterProductTransactions() -> [Transaction] {
        let transactionSelected = transactions[index]
        let filteredTransactions = transactions.filter { $0.sku == transactionSelected.sku }
        
        return filteredTransactions
    }
    
    func totalEuros(forTransactions transactions: [Transaction], withConversionRates rates: [ConversionRate]) -> Decimal {
        let totalEuros = transactions.reduce(Decimal(0.0)) { (accum, transaction) -> Decimal in
            if transaction.currency == kEUR {
                return accum + transaction.amount
            } else {
                return accum + Decimal(convertRate(from: transaction.currency, to: kEUR, withRates: rates)) * transaction.amount
            }
        }
        
        return totalEuros
    }
    
    func convertRate(from originCurrency: String, to targetCurrency: String, withRates rates: [ConversionRate], accumRate: Double = 1) -> Double {
        // Check if direct conversion exists
        let directConversion = rates.first { $0.from == originCurrency && $0.to == targetCurrency }
        if let directConversion = directConversion {
            // Stop recursion
            return directConversion.rate
        }
        // No direct conversion available
        // Get conversion rates with origin currency
        let originCurrencyRates = rates.filter { $0.from == originCurrency }
        if originCurrencyRates.isEmpty {
            return 0.0
        }
        for rate in originCurrencyRates {
            let rateTargetCurrency = rate.to
            var newRates = rates
            if let rateIndex = rates.firstIndex(of: rate) {
                newRates.remove(at: rateIndex)
            }
            
            return accumRate * convertRate(from: rateTargetCurrency, to: targetCurrency, withRates: newRates, accumRate: rate.rate)
        }
        
        return 0.0
    }
}
