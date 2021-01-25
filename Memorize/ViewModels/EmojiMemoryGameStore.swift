//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by Duong Pham on 1/24/21.
//

import SwiftUI

class EmojiMemoryGameStore: ObservableObject {
    @Published var themes = [Theme: String]()
    
    init() {
//        let defaultKey = "EmojiMemoryGame"
        
    }
}

//extension Dictionary where Key == Theme, Value == String {
//    var asPropertyList: [String:String] {
//        var uuidToName = [String:String]()
//        for (key, value) in self {
//            uuidToName[key.id.uuidString] = value
//        }
//        return uuidToName
//    }
//
//    init(fromPropertyList plist: Any?) {
//        self.init()
//        let uuidToName = plist as? [String:String] ?? [:]
//        for uuid in uuidToName.keys {
//            self[EmojiArtDocument(id: UUID(uuidString: uuid))] = uuidToName[uuid]
//        }
//    }
//}
