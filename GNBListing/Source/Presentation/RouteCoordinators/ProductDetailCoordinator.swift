//
//  ProductDetailCoordinator.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import UIKit

protocol ProductDetailCoordinatorProtocol: Coordinable {
    
}

class ProductDetailCoordinator: ProductDetailCoordinatorProtocol {
    private var productDetailViewController: ProductDetailViewController!
    
    var rootViewController: UIViewController {
        return productDetailViewController
    }
    
    init() {
        
    }
    
    func start() {
        productDetailViewController = assembly.productDetailViewController()
    }
}
