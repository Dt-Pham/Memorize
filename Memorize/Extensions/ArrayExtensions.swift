//
//  ArrayExtensions.swift
//  Memorize
//
//  Created by Duong Pham on 12/28/20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        self.count == 1 ? first : nil
    }
}
