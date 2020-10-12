//
//  Extensions.swift
//  Memorize
//
//  Created by Yulia Novikova on 10/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation
import SwiftUI

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        return firstIndex(where: { $0.id == matching.id })
    }
    
}

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

extension UIColor {
    
    func mix(with color: UIColor, amount: CGFloat) -> UIColor {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0

        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0

        getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return UIColor(
            red: red1 * (1.0 - amount) + red2 * amount,
            green: green1 * (1.0 - amount) + green2 * amount,
            blue: blue1 * (1.0 - amount) + blue2 * amount,
            alpha: alpha1
        )
    }
}


