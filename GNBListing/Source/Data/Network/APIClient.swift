//
//  APIClient.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

protocol APIClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any, Error>) -> Void)
}
