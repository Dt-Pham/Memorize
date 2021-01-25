//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>
    
    init(theme: Theme) {
        let emojis = theme.emojis.map {String($0)}
        game = MemoryGame<String>(
            themeName: theme.name,
            themeColor: Color(theme.color),
            numberOfPairsOfCards: emojis.count,
            createContent: { index in emojis[index] }
        )
    }
    
    // MARK: - Access
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var themeName: String {
        game.themeName
    }
    
    var themeColor: Color {
        game.themeColor
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intent(s)
    func newGame() {
//        let randomTheme = Theme.allCases.randomElement()!
//        game = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
//        print("json = \(game.json?.utf8 ?? "nil")")
    }
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
