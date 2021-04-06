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
                self?.view?.render(transactions: transactions)
                self?.storage.setTransactions(transactions)
            case .failure(let error):
                self?.coordinator.showError(message: error.description)
            }
        }
    }
}
