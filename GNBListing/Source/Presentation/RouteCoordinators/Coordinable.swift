//
//  Coordinable.swift
//  GNBListing
//
//  Created by Pablo Sanchez Egido on 05/04/2021.
//  Copyright © 2021 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol Coordinable {
    var rootViewController: UIViewController { get }
    
    func start()
}
