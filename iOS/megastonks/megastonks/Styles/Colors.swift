//
//  Colors.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-03.
//

import Foundation
import SwiftUI

extension Color {
    static var megaStonksLightGreen: Color {.init(.megaStonksLightGreen)}
    static var megaStonksDarkGreen: Color {.init(.megaStonksDarkGreen)}
    static var megaStonksLightGray: Color {.init(.megaStonksLightGray)}
    static var megaStonksOffWhite: Color {.init(.megaStonksOffWhite)}
    static var megaStonksRed: Color {.init(.megaStonksRed)}
}

extension UIColor {
    static var megaStonksLightGreen: UIColor { .init(red: 0.14, green: 0.24, blue: 0.16, alpha: 1) }
    static var megaStonksDarkGreen: UIColor { .init(red: 0.0, green: 0.12, blue: 0.05, alpha: 1) }
    static var megaStonksLightGray: UIColor { .init(red: 0.33, green: 0.33, blue: 0.33, alpha: 1) }
    static var megaStonksOffWhite: UIColor { .init(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)}
    static var megaStonksRed: UIColor { .init(red: 0.99, green: 0.34, blue: 0.34, alpha: 1)}
}
