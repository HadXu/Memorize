//
//  MemorizeApp.swift
//  Memorize
//
//  Created by lei on 2022/1/5.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
