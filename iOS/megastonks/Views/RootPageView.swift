//
//  RootPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI

struct RootPageView: View {
    
    @EnvironmentObject var userAuth: UserAuth

    var body: some View {
        if (userAuth.isLoggedin == nil) {
            LoginPageView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/).redacted(reason: .placeholder)
        }
        else if(!userAuth.isLoggedin!){
            LoginPageView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        else {
            AppPageView().onAppear(perform: {
                userAuth.refreshLogin()
            }).environmentObject(userAuth)
        }

    }
}

struct RootPageView_Previews: PreviewProvider {
    static var previews: some View {
        RootPageView().environmentObject(UserAuth())
        
    }
}
