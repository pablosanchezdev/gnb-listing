//
//  ProductDetailViewController.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private let presenter: ProductDetailPresenter
    
    private var transactions: [Transaction] = []
    
    init(presenter: ProductDetailPresenter) {
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

// MARK: - ProductDetailPresenterDelegate methods
extension ProductDetailViewController: ProductDetailPresenterDelegate {
    func setupView() {
        setupTableView()
    }
    
    func setTotal(_ total: String) {
        totalLabel.text = total
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
extension ProductDetailViewController: UITableViewDataSource {
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
extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionCell.height()
    }
}

// MARK: - Private methods
private extension ProductDetailViewController {
    func setupTableView() {
        tableView.registerReusableCell(withType: TransactionCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
