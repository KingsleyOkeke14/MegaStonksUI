//
//  LoadingIndication.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var body: some View {
        Color.black
            .opacity(0.6)
            .ignoresSafeArea()
            .overlay(
        
                HStack {
                    ZStack {
                Circle()
                    .stroke(lineWidth: 6)
                    .fill(Color.green)
                    .opacity(0.4)
                    .frame(width: 100, height: 100)
                    
                
                Circle()
                    .trim(from: animateStart ? 1/2 : 1/9, to: animateEnd ? 0.6 : 1)
                    .stroke(lineWidth: 6)
                    .rotationEffect(.degrees(isCircleRotating ? -360 : 0))
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.green)
                    .onAppear() {
                        withAnimation(Animation
                                        .linear(duration: 1)
                                        .repeatForever(autoreverses: false)) {
                            self.isCircleRotating.toggle()
                        }
                        withAnimation(Animation
                                        .linear(duration: 1)
                                        .delay(0.5)
                                        .repeatForever(autoreverses: true)) {
                            self.animateStart.toggle()
                        }
                        withAnimation(Animation
                                        .linear(duration: 1)
                                        .delay(1)
                                        .repeatForever(autoreverses: true)) {
                            self.animateEnd.toggle()
                        }
                    }
                Image("megastonkslogo")
                    .scaleEffect(0.34)
                    .aspectRatio(contentMode: .fit)
                    }
                }
            )
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView()
    }
}
