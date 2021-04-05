//
//  TransactionListViewController.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import UIKit

class TransactionListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    let presenter: TransactionListPresenter
    
    private var transactions: [Transaction] = []
    
    init(presenter: TransactionListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
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
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
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
        let transaction = transactions[indexPath.row]
        presenter.didSelect(transaction: transaction)
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
