//
//  MemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards =	Array<Card>()
        for index in (0..<numberOfPairsOfCards) {
            let content = createContent(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2+1))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        if let i = cards.firstIndex(matching: card) {
            cards[i].isFaceUp = !cards[i].isFaceUp
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
