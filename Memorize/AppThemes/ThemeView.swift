//
//  ThemeView.swift
//  Memorize
//
//  Created by Yulia Novikova on 10/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import SwiftUI

struct ThemeView: View {
    
    @EnvironmentObject var settings: GameSettings
    
    var themes = Themes.allCases
    
    @State private var selectedThemeIndex = Int(Themes.allCases.firstIndex(where: { $0 == GameSettings.th })!)
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
 
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        Picker("Theme", selection: $selectedThemeIndex.onChange(onThemeChange)) {
                            ForEach(0..<themes.count) {
                                Text("\(themes[$0].rawValue) \(themes[$0].emojiSet.joined(separator: ", "))")
                            }
                        }
                    }
                }
            }.background(Color(settings.theme.backgroundColor).edgesIgnoringSafeArea(.all))
        }
    }
    
    func onThemeChange(_ index: Int) {
        settings.theme = themes[index]
        GameSettings.th = themes[index]
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView().environmentObject(GameSettings(theme: .sea))
    }
}
