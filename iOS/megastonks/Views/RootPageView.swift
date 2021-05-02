//
//  RootPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI

struct RootPageView: View {
    
    @EnvironmentObject var userAuth: UserAuth
    
    
    let pub = NotificationCenter.default.publisher(for: .didAuthTokenExpire)
    
    @State var bannerData:BannerData = BannerData(title: "Authentication Failed", detail: "Your Session has expired and cannot be authenticated at this time. You will be logged out in 6 seconds. Please Login Again", type: .Error)
    
    var body: some View {
        if (userAuth.isLoggedin == nil) {
            VStack{
                LoginPageView().redacted(reason: .placeholder).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                Text("Confirming Authentication....")
                    .bold()
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
            }.disabled(true)
        }
        else if(!userAuth.isLoggedin!){
            LoginPageView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        else {
            AppPageView()
                .onAppear(perform: {
                    userAuth.refreshLogin()
                })
                .banner(data: $bannerData, show: $userAuth.showAuthError)
                .onReceive(pub, perform: { _ in
                    userAuth.refreshLogin()
                })
                .environmentObject(userAuth)
        }
    }
}

struct RootPageView_Previews: PreviewProvider {
    static var previews: some View {
        
        RootPageView().environmentObject(UserAuth())
        
    }
}
