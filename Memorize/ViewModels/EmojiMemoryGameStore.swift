//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by Duong Pham on 1/24/21.
//

import SwiftUI
import Combine

class EmojiMemoryGameStore: ObservableObject {
    let name: String
    @Published var themes = [Theme]()
    
    func name(for theme: Theme) -> String {
        theme.name
    }
    
    func setName(_ name: String, for theme: Theme) {
        let id = themes.firstIndex(matching: theme)
        assert(id != nil)
        themes[id!].name = name
    }
    
    func addTheme(named name: String = "Nameless Theme") {
        themes.append(Theme())
    }
    
    func addTheme(_ theme: Theme) {
        themes.append(theme)
    }

    func removeTheme(_ theme: Theme) {
        let id = themes.firstIndex(matching: theme)
        assert(id != nil)
        themes.remove(at: id!)
    }
    
    private var autosave: AnyCancellable?
    
    init(named name: String = "Emoji Memory Game") {
        self.name = name
        let defaultKey = "EmojiMemoryGameStore.\(name)"
        themes = Array(fromPropertyList: UserDefaults.standard.object(forKey: defaultKey))
        
        autosave = $themes.sink { names in
            UserDefaults.standard.set(names.asPropertyList, forKey: defaultKey)
        }
    }
}

extension Array where Element == Theme {
    var asPropertyList: [Data?] {
        var pList = [Data?]()
        for theme in self {
            pList.append(theme.json)
        }
        return pList
    }
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let data = plist as? [Data?] ?? []
        for json in data {
            let theme = Theme(json: json)!
            self.append(theme)
        }
    }
}
