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
    
    
    var body: some View {
        NavigationView{
            VStack{
                PortfolioSummaryView(isAllTimeGains: $isAllTimeGains)
                    .environmentObject(myAppObjects)
                    .environmentObject(userAuth)
                PageView(pages: [AssetPorfolioPage(isAllTimeGains: $isAllTimeGains)
                                    .environmentObject(myAppObjects)
                                    .environmentObject(userAuth)], currentPage: Binding.constant(0))

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
