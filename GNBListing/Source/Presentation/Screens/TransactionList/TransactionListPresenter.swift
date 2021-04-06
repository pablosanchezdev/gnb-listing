//
//  TransactionListPresenter.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

protocol TransactionListPresenterDelegate: class {
    func setupView()
    func render(transactions: [Transaction])
    func showError(message: String)
}

class TransactionListPresenter: BasePresenter {
    weak var view: TransactionListPresenterDelegate?
    
    private let coordinator: TransactionListCoordinatorProtocol
    private let repository: TransactionRepository
    private let storage: TransactionStorage
    
    init(coordinator: TransactionListCoordinatorProtocol, repository: TransactionRepository, storage: TransactionStorage) {
        self.coordinator = coordinator
        self.repository = repository
        self.storage = storage
    }
    
    override func prepareView(for state: ViewState) {
        switch state {
        case .didLoad:
            view?.setupView()
        case .didAppear:
            fetchTransactions()
        default:
            break
        }
    }
    
    func didSelectTransaction(atIndex index: Int) {
        coordinator.didSelectTransaction(atIndex: index)
    }
}

// MARK: - Private methods
private extension TransactionListPresenter {
    func fetchTransactions() {
        repository.getTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                let transactionss = [Transaction(sku: "1", amount: 10, currency: "EUR"), Transaction(sku: "2", amount: 10, currency: "USD"), Transaction(sku: "1", amount: 5, currency: "USD"), Transaction(sku: "1", amount: 1, currency: "AUD")]
                self?.view?.render(transactions: transactionss)
                self?.storage.setTransactions(transactionss)
            case .failure(let error):
                self?.view?.showError(message: error.description)
            }
        }
    }
}
