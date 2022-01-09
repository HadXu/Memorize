//
//  EmojiMomoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚕","✈️","🛻","🛰","🚟","🚚","🚍","🚊","🚢","🚀","🚁","🎠",
                    "💾", "⚓️", "🪝", "🗼", "🏰", "🏝", "🏠","🚏", "⌚️","📱","📲","💻","⌨️"]

    static func create() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8, createCardContent: { index in
            emojis[index]
        })
    }

    @Published private var model : MemoryGame<String> = create();
    
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
        
}
  
