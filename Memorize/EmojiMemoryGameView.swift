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

struct CardView: View, Animatable {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(60), clockwise: true)
                        .opacity(0.5).padding()
                    Text(card.content)
                        .rotationEffect(card.isMatched ? Angle.degrees(360) : Angle.degrees(0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .font(Font.system(size: fontSize(geometry.size)))
            }
        }
    }
    
    // MARKS: - Drawing constants
    private func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiGame: EmojiMemoryGame())
    }
}
