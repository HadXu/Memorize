//
//  MemoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards : Array<Card>
    
    private var iii : Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let pp = iii {
                if cards[chosenIndex].content == cards[pp].content {
                    cards[chosenIndex].isMatched = true
                    cards[pp].isMatched = true
                }
                iii = nil
            }else{
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                iii = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("choosen card = \(cards)")
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
