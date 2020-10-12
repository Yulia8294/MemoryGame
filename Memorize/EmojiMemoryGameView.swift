//
//  ContentView.swift
//  Memorize
//
//  Created by Yulia Novikova on 8/11/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @EnvironmentObject var settings: GameSettings
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
            .foregroundColor(Color(settings.theme.accentColor))
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .background(Color(settings.theme.backgroundColor)).edgesIgnoringSafeArea(.bottom)
    }
}

struct CardView: View {
        
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
//MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame()).environmentObject(GameSettings())
    }
}
