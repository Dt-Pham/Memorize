//
//  MemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var themeName: String
    var themeColor: Color
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in 0..<cards.count {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(themeName: String, themeColor: Color, numberOfPairsOfCards: Int, createContent: (Int) -> CardContent) {
        cards =	Array<Card>()
        for index in (0..<numberOfPairsOfCards) {
            let content = createContent(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2+1))
        }
        cards.shuffle()
        self.themeName = themeName
        self.themeColor = themeColor
    }
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp {
            if let potenialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                print(cards[potenialMatchedIndex].content)
                print(cards[chosenIndex].content)
                print(cards[chosenIndex].content == cards[potenialMatchedIndex].content)
                if (cards[chosenIndex].content == cards[potenialMatchedIndex].content) {
                    cards[chosenIndex].isMatched = true
                    cards[potenialMatchedIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }
            else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
