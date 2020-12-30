//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Duong Pham on 12/25/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        Group {
            Text(emojiGame.themeName).font(.largeTitle)
            Text("Score: \(emojiGame.score)")
            Button("New Game") { emojiGame.newGame() }
            Grid(items: emojiGame.cards) { card in
                CardView(card: card).onTapGesture(perform: {
                    emojiGame.choose(card: card)
                })
                .padding(5)
            }
        }
        .foregroundColor(emojiGame.themeColor)
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
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(60), clockwise: true)
                        .opacity(0.5).padding()
                    Text(card.content)
                }
                else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(geometry.size)))
        }
    }
    
    // MARKS: - Drawing constants
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
    private func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiGame: EmojiMemoryGame())
    }
}
