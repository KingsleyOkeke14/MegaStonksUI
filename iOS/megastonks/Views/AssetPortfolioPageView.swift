//
//  AssetPortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-04.
//

import SwiftUI

struct AssetPortfolioPageView: View {
    
    @State var isAllTimeGains:Bool = true
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
        init() {
            let coloredAppearance = UINavigationBarAppearance()
    
            // this overrides everything you have set up earlier.
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = .black
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    
            // to make everything work normally
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    
            UINavigationBar.appearance().tintColor = .systemGray4
        }
    
    var body: some View {
        NavigationView{
            VStack{
                PortfolioSummaryView(isAllTimeGains: $isAllTimeGains)
                    .environmentObject(myAppObjects)
                    .environmentObject(userAuth)
                PageView(pages: [AssetPorfolioPage(isAllTimeGains: $isAllTimeGains)], currentPage: Binding.constant(0))
                    .padding(.top, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AssetPortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPortfolioPageView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
            .environmentObject(AppObjects())
    }
}
