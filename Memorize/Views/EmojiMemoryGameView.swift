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
            Button("New Game") {
                withAnimation(.easeInOut) {
                    emojiGame.newGame()
                }
            }
            Grid(items: emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(Animation.linear(duration: flippingDuration)) {
                        emojiGame.choose(card: card)
                    }
                }
                .padding(paddingLength)
            }
        }
        .foregroundColor(emojiGame.themeColor)
    }
    
    // MARK: - Drawing constants
    private let flippingDuration: TimeInterval = 0.75
    private let paddingLength: CGFloat = 5
}

struct CardView: View, Animatable {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(startAngleOffset), endAngle: Angle.degrees(-animatedBonusRemaining * 360 + startAngleOffset), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        }
                        else {
                            Pie(startAngle: Angle.degrees(startAngleOffset), endAngle: Angle.degrees(-card.bonusRemaining * 360 + startAngleOffset), clockwise: true)
                        }
                    }
                    .opacity(opacity).padding()
                    Text(card.content)
                        .rotationEffect(card.isMatched ? Angle.degrees(360) : Angle.degrees(0))
                        .animation(card.isMatched ? Animation.linear(duration: spinningDuration).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .font(Font.system(size: fontSize(geometry.size)))
                .transition(AnyTransition.scale)
            }
        }
    }
    
    // MARKS: - Drawing constants
    private let opacity: Double = 0.4
    private let spinningDuration: TimeInterval = 1
    private let startAngleOffset: Double = -90
    
    private func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiGame: EmojiMemoryGame())
    }
}
