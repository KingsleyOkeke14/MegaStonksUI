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
                        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                        .environmentObject(appObject)
                    
                    PortfolioPageView()
                        .tabItem {
                            Label("Portfolio", systemImage: "banknote")
                        }.tag(1)
                        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                    
                    ProfilePageView()
                        .tabItem {
                            Label("Account", systemImage: "person")
                        }.tag(2)
                        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                }.accentColor(.white)
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
    }
}
