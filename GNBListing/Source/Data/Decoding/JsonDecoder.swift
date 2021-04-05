//
//  JsonDecoder.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

struct JsonDecoder: Decoder {
    func decode<T>(_ data: Any, as: T.Type) throws -> T where T: Decodable {
        guard let json = data as? [[String: Any]] else {
            throw AppError.invalidJSON
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            throw AppError.decodingJSON
        }
    }
}
