//
//  APIClient.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

protocol APIClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any, Error>) -> Void)
}
