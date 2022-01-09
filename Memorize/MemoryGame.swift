//
//  MemoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards : Array<Card>
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        print("choosen card = \(cards)")
    } 
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for index in 0..<numberOfPairsOfCards { 
            let content = createCardContent(index)
            cards.append(Card(content: content, id:index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
    }
    
    
    struct Card : Identifiable { 
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
    }
}
