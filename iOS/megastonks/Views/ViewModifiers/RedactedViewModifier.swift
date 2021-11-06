//
//  RedactedViewModifier.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-09.
//

import Foundation
import SwiftUI

public enum RedactionType {
    case customPlaceholder
    case scaled
    case blurred
    case loading
}


struct Redactable: ViewModifier {
    let type: RedactionType?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch type {
        case .customPlaceholder:
            content
                .modifier(Placeholder())
        case .scaled:
            content
                .modifier(Scaled())
        case .blurred:
            content
                .modifier(Blurred())
        case .loading:
            content
                .modifier(Loading())
        case nil:
            content
        }
    }
}

struct Placeholder: ViewModifier {
    
    @State private var condition: Bool = false
    func body(content: Content) -> some View {
        content
            .accessibility(label: Text("Placeholder"))
            .redacted(reason: .placeholder)
            .disabled(true)
            .opacity(condition ? 0.6 : 1.0)
            .onAppear { condition = true }
    }
}

struct Scaled: ViewModifier {
    
    @State private var condition: Bool = false
    func body(content: Content) -> some View {
        content
            .accessibility(label: Text("Scaled"))
            .redacted(reason: .placeholder)
            .disabled(true)
            .scaleEffect(condition ? 0.9 : 1.0)
            .animation(Animation
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true))
            .onAppear { condition = true }
    }
}

struct Blurred: ViewModifier {
    
    @State private var condition: Bool = false
    func body(content: Content) -> some View {
        content
            
            .accessibility(label: Text("Blurred"))
            .redacted(reason: .placeholder)
            .disabled(true)
            .blur(radius: condition ? 0.0 : 1.6)
            //.transition(.move(edge: .leading))
            .animation(Animation
                        .linear(duration: 1)
                        .repeatForever(autoreverses: true))
            .onAppear { condition = true }
    }
}

struct Loading: ViewModifier {
    
    @State private var condition: Bool = false
    func body(content: Content) -> some View {
        content
            
            .accessibility(label: Text("Loading"))
            .disabled(true)
            .opacity(condition ? 0.2 : 1.0)
            .shadow(color: .white, radius: 10, x: 4, y: 4)
            .animation(.easeOut.delay(0.2).speed(0.6) .repeatForever(autoreverses: true))
            .onAppear(perform: {condition.toggle()})
    }
}
