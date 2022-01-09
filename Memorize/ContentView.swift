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
        ZStack {
            let shape = RoundedRectangle(cornerRadius:20)
            if card.isFaceUp  {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
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
