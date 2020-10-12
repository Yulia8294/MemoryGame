//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yulia Novikova on 8/11/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = GameSettings.th
        let emojis: Array<String> = theme.emojiSet
        return MemoryGame<String>(theme: theme, numberOfPairsOfCards: 5) { index in
            emojis[index]
        }
    }
    
    //MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
