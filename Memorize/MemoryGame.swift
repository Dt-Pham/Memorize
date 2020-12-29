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
    var score: Int
    
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
        self.score = 0
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
                    score += 2
                }
                else {
                    if cards[chosenIndex].isSeen {
                        score -= 1
                    }
                    if cards[potenialMatchedIndex].isSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].isSeen = true
                cards[potenialMatchedIndex].isSeen = true
            }
            else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
