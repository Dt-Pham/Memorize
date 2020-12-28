//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "🍭", "🍫"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5), createContent: { index in
            emojis[index];
        })
    }
    
    // MARK: - Access
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
