//
//  ConversionRate.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

struct ConversionRate {
    let from: String
    let to: String
    let rate: Double
}

// MARK: - Equatable
extension ConversionRate: Equatable { }
