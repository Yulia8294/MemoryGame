//
//  GameSettings.swift
//  Memorize
//
//  Created by Yulia Novikova on 10/12/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation

class GameSettings: ObservableObject {
    
    @Published var theme: Themes = .sea {
        didSet {
            print("Theme changed to \(theme)")
        }
    }
    
    init(theme: Themes = .sea) {
        self.theme = theme
    }
    
}
