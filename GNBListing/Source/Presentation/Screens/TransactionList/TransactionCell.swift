//
//  TransactionCell.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import UIKit

class TransactionCell: UITableViewCell, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    class func height() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.sku
        detailLabel.text = "\(transaction.amount) \(transaction.currency)"
    }
}

// MARK: - Private methods
private extension TransactionCell {
    func setupView() {
        accessoryType = .disclosureIndicator
    }
}
