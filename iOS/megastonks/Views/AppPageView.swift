//
//  AppPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI

struct AppPageView: View {
    @State private var selection = 0
    
    @EnvironmentObject var userAuth: UserAuth
    
    @StateObject var appObject: AppObjects = AppObjects()
    
    
    let myColors = MyColors()
    
    var body: some View {
        VStack {
            
            if(userAuth.user.isOnBoarded){
                TabView(selection: $selection) {
                    WatchListPageView()
                        .tabItem {
                            Label("WatchList", systemImage: "eyeglasses")
                        }.tag(0)
                        .preferredColorScheme(.dark)
                        .environmentObject(appObject)
                    
                    NewsPageView()
                        .environmentObject(appObject)
                        .tabItem {
                            Label("News Feed", systemImage: "newspaper")
                        }.tag(1)
                        .preferredColorScheme(.dark)
                    
                    PortfolioPageView()
                        .environmentObject(userAuth)
                        .environmentObject(appObject)
                        .tabItem {
                            Label("Portfolio", systemImage: "banknote")
                        }.tag(2)
                        .preferredColorScheme(.dark)
                    
                    ProfilePageView()
                        .environmentObject(userAuth)
                        .environmentObject(appObject)
                        .tabItem {
                            Label("Account", systemImage: "person")
                        }.tag(3)
                        .preferredColorScheme(.dark)
                }
                .animation(.easeInOut)
                .transition(.scale)
                .accentColor(.white)
                .onAppear() {
                    UITabBar.appearance().barTintColor = .black
                }
            }
            else{
                OnBoardPageView()
            }
            
        }
    }
    
}

struct AppPageView_Previews: PreviewProvider {
    static var previews: some View {
        AppPageView().environmentObject(UserAuth())
            .environmentObject(AppObjects())
    }
}
