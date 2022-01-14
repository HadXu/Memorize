//
//  MemoryGame.swift
//  Memorize
//
//  Created by lei on 2022/1/8.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards : Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard : Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potenialMatchedIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potenialMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potenialMatchedIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
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

extension Array {
    var oneAndOnly:  Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
