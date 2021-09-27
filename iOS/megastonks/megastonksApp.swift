//
//  megastonksApp.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

@main
struct megastonksApp: App {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .systemGray4
        UINavigationBar.appearance().isTranslucent = true
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor(myColors.greenColor.opacity(0.6))
    }
    
    var body: some Scene {
        WindowGroup {
            let userAuth = UserAuth()
            RootPageView().environmentObject(userAuth)
        }
        
    }
}
