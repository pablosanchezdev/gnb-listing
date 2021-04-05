//
//  String+Plist.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 05/04/21.
//

import Foundation

extension String {
    func fromPlist() -> String? {
        return Bundle.main.infoDictionary?[self] as? String
    }
}
