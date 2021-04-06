//
//  TransactionListViewController.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import UIKit

class TransactionListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let presenter: TransactionListPresenter
    
    private var transactions: [Transaction] = []
    
    init(presenter: TransactionListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.prepareView(for: .didLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.prepareView(for: .didAppear)
    }
}

// MARK: - TransactionListPresenterDelegate methods
extension TransactionListViewController: TransactionListPresenterDelegate {
    func setupView() {
        setupTableView()
    }
    
    func render(transactions: [Transaction]) {
        self.transactions = transactions
        tableView.reloadData()
    }
    
    func showError(message: String) {
        let alert = UIAlertController.commonAcceptAlert(withTitle: "Error", message: message)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource methods
extension TransactionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withType: TransactionCell.self)
        cell.configure(with: transaction)
        
        return cell
    }
}

// MARK: - UITableViewDelegate methods
extension TransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectTransaction(atIndex: indexPath.row)
    }
}

// MARK: - Private methods
private extension TransactionListViewController {
    func setupTableView() {
        tableView.registerReusableCell(withType: TransactionCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
