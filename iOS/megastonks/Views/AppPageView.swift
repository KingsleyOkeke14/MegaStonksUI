//
//  AppPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI

struct AppPageView: View {
    @State private var selection = 0
    let myColors = MyColors()
    
    var body: some View {
        
        Color.black
            .ignoresSafeArea()
            .overlay(
                    TabView(selection: $selection) {
                        WatchListPageView()
                            .tabItem {
                                Label("WatchList", systemImage: "eyeglasses")
                            }.tag(0)

                        PortfolioPageView()
                            .tabItem {
                                Label("Portfolio", systemImage: "banknote")
                            }.tag(1)
                        
                        ProfilePageView()
                            .tabItem {
                                Label("Account", systemImage: "person")
                            }.tag(2)
                    }.accentColor(.green)
                    .onAppear() {
                        UITabBar.appearance().barTintColor = .black
                           }
                    

            
            )
    }
}

struct AppPageView_Previews: PreviewProvider {
    static var previews: some View {
        AppPageView()
    }
}
