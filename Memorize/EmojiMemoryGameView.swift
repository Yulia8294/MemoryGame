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
        NavigationView {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
                .foregroundColor(Color(settings.theme.accentColor))
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .background(Color(settings.theme.backgroundColor).edgesIgnoringSafeArea(.all))
           
        }
        .navigationBarItems(trailing: Button("New game") {
            withAnimation(.easeInOut) { viewModel.newGame() }
        })
        .foregroundColor(Color(settings.theme.accentColor))
    }
}


struct CardView: View {
        
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90), clockwise: true)
                            .onAppear() {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360 - 90), clockwise: true)
                    }
                }.padding(5).opacity(0.4)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }.cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.offset(x: -1000, y: 0))
            
        }
    }
    
//MARK: - Drawing Constants
    
 
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game).environmentObject(GameSettings())
    }
}
