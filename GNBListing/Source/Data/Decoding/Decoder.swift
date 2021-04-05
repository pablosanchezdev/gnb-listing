//
//  Decoder.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

protocol Decoder {
    func decode<T>(_ value: Any, as: T.Type) throws -> T where T: Decodable
}
