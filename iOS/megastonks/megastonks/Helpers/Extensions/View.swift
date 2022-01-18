//
//  View.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-08.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    func frame(dimension: CGFloat?) -> some View {
        frame(width: dimension, height: dimension)
    }
}
