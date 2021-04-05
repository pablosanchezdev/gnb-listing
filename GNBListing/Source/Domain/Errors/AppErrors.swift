//
//  AppErrors.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

enum AppError: String, Error {
    case apiRequest = "API request failed"
    case invalidJSON = "Invalid json received"
    case decodingJSON = "Error while decoding json"
    
    var description: String {
        return self.rawValue
    }
}
