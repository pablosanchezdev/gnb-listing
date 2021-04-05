//
//  AppErrors.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

enum AppError: Error {
    case apiRequest
    case invalidJSON
    case decodingJSON
}
