//
//  MemoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards : Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for index in 0..<numberOfPairsOfCards {
            let content = createCardContent(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
