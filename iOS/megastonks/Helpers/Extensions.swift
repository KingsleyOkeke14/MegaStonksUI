//
//  Extensions.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation
import SwiftUI
import UIKit

extension Double {

    func toString(withFloatingPoints points: Int = 0) -> String {
        return String(self)
    }
    
    func formatPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
    
    func formatPercentChange() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.positivePrefix = numberFormatter.plusSign
        
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
       func abbreviated() -> String {
            let abbrev = "KMBTPE"
        return abbrev
                .enumerated()
                .reversed()
                .reduce(nil as String?) { accum, tuple in
                    let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                    let format = (factor - floor(factor) == 0 ? "%.0f%@" : "%.1f%@")
                    return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
                } ?? String(self)
        }
    
}


extension Int {
        var abbreviated: String {
            let abbrev = "KMBTPE"
            return abbrev
                .enumerated()
                .reversed()
                .reduce(nil as String?) { accum, tuple in
                    let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                    let format = (factor - floor(factor) == 0 ? "%.0f%@" : "%.1f%@")
                    return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
                } ?? String(self)
        }
}


extension Color {
 
    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension Notification.Name {
    static let didAuthTokenExpire = Notification.Name("didAuthTokenExpire")
}
