//
//  ContentView.swift
//  Memorize
//
//  Created by lei on 2022/1/5.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    
    var emojis = ["🪝", "🚕","✈️","🛻","🛰","🚟","🚚","🚍","🚊","🚢","🚀","🚁","🎠",
                    "💾", "⚓️", "🗼", "🏰", "🏝", "🏠","🚏", "⌚️","📱","📲","💻","⌨️"]
    
    
    @State private var dealt = Set<Int>();
    
    private func deal(_ card: MemoryGame<String>.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemoryGame<String>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var gamebody : some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) ||  card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        
        .foregroundColor(.red)

    }
    
    private func deal(for card: MemoryGame<String>.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (0.8  / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: 60, height: 90)
        .foregroundColor(.red)
        .onTapGesture {
                for card in game.cards {
                    withAnimation(deal(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    var body:  some View {
        VStack {
            gamebody
            deckBody
            shuffle
        }
        .padding( ) 
    }
}

struct CardView: View {
    let card : MemoryGame<String>.Card
    
    @State private var boundtime : Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-boundtime)*360-90))
                            .onAppear {
                                boundtime = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    boundtime = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(5)
                .opacity(0.6)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFitSize: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFitSize size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size:CGSize) -> Font {
        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let linewidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}
 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            
    } 
}
