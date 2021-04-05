//
//  AlamofireAPIClient.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation
import Alamofire

struct AlamofireAPIClient: APIClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any, Error>) -> Void) {
        AF
            .request(endpoint.path,
                     method: endpoint.httpMethod.toAlamofireHTTPMethod(),
                     parameters: endpoint.body,
                     headers: endpoint.headers?.toAlamofireHeaders())
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    completion(.success(json))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

// MARK: - HttpMethod private methods
private extension HttpMethod {
    func toAlamofireHTTPMethod() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
}

// MARK: - Dictionary private methods
private extension Dictionary where Key == String, Value == String {
    func toAlamofireHeaders() -> HTTPHeaders {
        return HTTPHeaders(self)
    }
}
