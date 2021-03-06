//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        let store = EmojiMemoryGameStore()
        WindowGroup {
            EmojiMemoryThemeChooser().environmentObject(store)
        }
    }
}
