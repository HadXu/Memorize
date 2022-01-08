//
//  EmojiMomoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🚕","✈️","🛻","🛰","🚟","🚚","🚍","🚊","🚢","🚀","🚁","🎠",
                    "💾", "⚓️", "🪝", "🗼", "🏰", "🏝", "🏠","🚏", "⌚️","📱","📲","💻","⌨️"]

    static func create() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: { index in
            emojis[index]
        })
    }
     
    private var model : MemoryGame<String> = create();
    
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    }
        
}
 
