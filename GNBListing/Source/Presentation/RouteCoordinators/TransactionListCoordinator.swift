//
//  TransactionListCoordinator.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import UIKit

protocol TransactionListCoordinatorProtocol: Coordinable {
    func didSelectTransaction(atIndex index: Int)
    func showError(message: String)
}

class TransactionListCoordinator: TransactionListCoordinatorProtocol {
    private var navController: UINavigationController!
    
    var rootViewController: UIViewController {
        return navController
    }
    
    func start() {
        let viewController = assembly.transactionListViewController()
        navController = UINavigationController(rootViewController: viewController)
    }
    
    func didSelectTransaction(atIndex index: Int) {
        let recipeDetailCoordinator = assembly.productDetailCoordinator(index: index)
        navController.pushViewController(recipeDetailCoordinator.rootViewController, animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController.commonAcceptAlert(withTitle: "Error", message: message)
        navController.present(alert, animated: true, completion: nil)
    }
}
