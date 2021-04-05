//
//  ConversionRateAPI.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

struct ConversionRateAPI: Decodable {
    let from: String
    let to: String
    let rate: String
}
