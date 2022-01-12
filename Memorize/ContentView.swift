//
//  ContentView.swift
//  Memorize
//
//  Created by lei on 2022/1/5.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame 
    
    var emojis = ["🚕","✈️","🛻","🛰","🚟","🚚","🚍","🚊","🚢","🚀","🚁","🎠",
                    "💾", "⚓️", "🪝", "🗼", "🏰", "🏝", "🏠","🚏", "⌚️","📱","📲","💻","⌨️"]
    
    @State var emojiCount = 7
     
    var body:  some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

struct CardView: View {
    let card : MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius:DrawingConstants.cornerRadius)
                if card.isFaceUp  {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.linewidth)
                    Text(card.content).font(font(in: geometry.size))
                }else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size:CGSize) -> Font {
        Font.system(size:min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let linewidth: CGFloat = 3
        static let fontScale: CGFloat = 0.9
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light )
            
    } 
}
