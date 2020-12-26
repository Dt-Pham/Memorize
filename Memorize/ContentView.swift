//
//  ContentView.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

struct ContentView: View {
    var emojiGame: EmojiMemoryGame
    
    var body: some View {
        HStack() {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture(perform: {
                    emojiGame.choose(card: card)
                })
            }
        }
        .foregroundColor(.orange)
        .padding()
        .font(emojiGame.cards.count < 5 ? .largeTitle : .title)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack() {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                Text(card.content)
            }
            else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiGame: EmojiMemoryGame())
    }
}
