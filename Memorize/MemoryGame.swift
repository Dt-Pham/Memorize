//
//  MemoryGame.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

struct MemoryGame<CardContent>: Codable where CardContent: Equatable, CardContent: Codable {
    private(set) var cards: [Card]
    private(set) var themeName: String
    private(set) var score: Int
    private var rgbColor: UIColor.RGB
    
    private(set) var themeColor: Color {
        get {
            Color(rgbColor)
        }
        set {
            rgbColor = UIColor(newValue).rgb
        }
    }
    
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
    
    var json: Data? {
        try? JSONEncoder().encode(self)
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
        self.rgbColor = UIColor(themeColor).rgb
        self.score = 0
    }
    
    mutating func choose(card: Card) {
        // 1print("Card chosen: \(card)")
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
    
    struct Card: Identifiable, Codable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }
                else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
        
        
        // MARK: Bonus Time
        
        // this could give matching bonus points if the user matches the card before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been faceup if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before teh bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && (!isMatched && bonusTimeRemaining > 0)
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
    }
}
