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
        if !userAuth.isLoggedin {
            LoginPageView()
        } else {
            AppPageView()
        }

    }
}

struct RootPageView_Previews: PreviewProvider {
    static var previews: some View {
        let userAuth = UserAuth()
        RootPageView().environmentObject(userAuth)
    }
}
