//
//  ProductDetailCoordinator.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import UIKit

protocol ProductDetailCoordinatorProtocol: Coordinable {
    func showError(message: String)
}

class ProductDetailCoordinator: ProductDetailCoordinatorProtocol {
    private var productDetailViewController: ProductDetailViewController!
    
    var rootViewController: UIViewController {
        return productDetailViewController
    }
    
    func start() {
        productDetailViewController = assembly.productDetailViewController()
    }
    
    func showError(message: String) {
        let alert = UIAlertController.commonAcceptAlert(withTitle: "Error", message: message)
        productDetailViewController.present(alert, animated: true, completion: nil)
    }
}
