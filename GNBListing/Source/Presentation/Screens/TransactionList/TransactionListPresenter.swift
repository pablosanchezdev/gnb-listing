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
    
    let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
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
    
    func didSelect(transaction: Transaction) {
        
    }
}

// MARK: - Private methods
private extension TransactionListPresenter {
    func fetchTransactions() {
        repository.getTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.view?.render(transactions: transactions)
            case .failure(let error):
                self?.view?.showError(message: error.description)
            }
        }
    }
}
