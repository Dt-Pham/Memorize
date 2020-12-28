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
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    Text(card.content)
                }
                else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .font(Font.system(size: fontSize(geometry.size)))
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARKS: - Drawing constants
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiGame: EmojiMemoryGame())
    }
}
