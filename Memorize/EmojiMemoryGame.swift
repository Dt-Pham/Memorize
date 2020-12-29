//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(theme: .halloween)
    
    enum Theme: CaseIterable {
        case halloween
        case sport
        case flower
        case sweet
        case horoscope
        case heart
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        var emojis: [String]
        var name: String
        var color: Color
        switch theme {
        case .halloween:
            name = "Halloween"
            emojis = ["👻", "🎃", "🕷", "☠️", "💀", "😈"]
            color = .orange
        case .sport:
            name = "Sport"
            emojis = ["🥊", "🏊🏼‍♂️", "🤺", "⚽️", "🏓", "🎱", "🏀", "🏈", "🏸", "🏒", "⛳️"]
            color = .green
        case .flower:
            name = "Flower"
            emojis = ["💐", "🌷", "🌸", "🌹", "🌺", "🌻", "🌼", "🥀", "💮"]
            color = .pink
        case .sweet:
            name = "Sweet"
            emojis = ["🍩", "🍪", "🍫", "🍬", "🍭", "🥮", "🧁", "🍡", "🍨", "🍧"]
            color = .yellow
        case .horoscope:
            name = "Horoscope"
            emojis = ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"]
            color = .purple
        case .heart:
            name = "Heart"
            emojis = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝"]
            color = .red
        }
        return MemoryGame<String>(themeName: name, themeColor: color, numberOfPairsOfCards: Int.random(in: 2...emojis.count), createContent: { index in
            emojis[index];
        })
    }
    
    func newGame() {
        let randomTheme = Theme.allCases.randomElement()!
        game = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
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
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
