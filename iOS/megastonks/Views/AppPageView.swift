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
                            Label("WatchList", systemImage: "eye")
                        }.tag(0)
                        .preferredColorScheme(.dark)
                        .environmentObject(appObject)
                    NewsPageView()
                        .environmentObject(appObject)
                        .tabItem {
                            Label("News Feed", systemImage: selection == 1 ? "newspaper.fill" : "newspaper")
                        }.tag(1)
                        .preferredColorScheme(.dark)
                    
                    AssetPortfolioPageView()
                        .environmentObject(userAuth)
                        .environmentObject(appObject)
                        .tabItem {
                            Label("Portfolio", systemImage: selection == 2 ? "banknote.fill" : "banknote")
                        }.tag(2)
                        .preferredColorScheme(.dark)
                    
                    ChatRootView(showExitButton: false)
                        .environmentObject(userAuth)
                        .tabItem {
                            Label("Conversations", systemImage: selection == 3 ? "bubble.left.and.bubble.right.fill" : "bubble.left.and.bubble.right")
                        }.tag(3)
                        .preferredColorScheme(.dark)
                    
                    ProfilePageView()
                        .environmentObject(userAuth)
                        .environmentObject(appObject)
                        .tabItem {
                            Label("Account", systemImage: selection == 4 ? "person.fill" : "person")
                        }.tag(4)
                        .preferredColorScheme(.dark)
                    
                }
                .accentColor(myColors.greenColor)
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
