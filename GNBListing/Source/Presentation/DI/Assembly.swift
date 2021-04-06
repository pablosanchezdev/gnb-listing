//
//  Assembly.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/04/2021.
//  Copyright © 2021 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol Assembly {
    func transactionListViewController() -> TransactionListViewController
    func transactionListCoordinator() -> Coordinable
    
    func productDetailViewController() -> ProductDetailViewController
    func productDetailCoordinator(index: Int) -> Coordinable
}
