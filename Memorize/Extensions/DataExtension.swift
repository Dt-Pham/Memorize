//
//  DataExtension.swift
//  Memorize
//
//  Created by Duong Pham on 1/17/21.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8) }
}
