//
//  Endpoint.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

enum HttpMethod {
    case get
}

protocol Endpoint {
    var httpMethod: HttpMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
}
