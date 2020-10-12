//
//  StartView.swift
//  Memorize
//
//  Created by Yulia Novikova on 10/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var settings: GameSettings
    
    @State var showLoginView: Bool = true
    @State var isChoosingTheme: Bool = false
    @State var isLinkActive = false

        
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                let game = EmojiMemoryGame()
                NavigationLink(destination: EmojiMemoryGameView(viewModel: game), isActive: $isLinkActive) {
                    Button("New Game") {
                        game.newGame()
                        isLinkActive = true
                    }
                }.buttonStyle(MenuButtonStyle(with: settings.theme.accentColor))
                Button("Choose theme") {
                    isChoosingTheme = true
                }.buttonStyle(MenuButtonStyle(with: settings.theme.accentColor))
                .sheet(isPresented: $isChoosingTheme, content: {
                    ThemeView()
                })
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = settings.theme.backgroundColor
                    nc.navigationBar.isTranslucent = false
                    nc.navigationBar.tintColor = settings.theme.accentColor
                })
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center)
            .background(Color(settings.theme.backgroundColor)).edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}
    


struct MenuButtonStyle: ButtonStyle {
    
    var primaryColor: UIColor
    
    var secondaryColor: UIColor {
        primaryColor.lighterColor(removeSaturation: 0.3, resultAlpha: 1)
    }
    
    init(with color: UIColor) {
        primaryColor = color
    }
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(primaryColor), Color(secondaryColor)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(GameSettings())
    }
}
