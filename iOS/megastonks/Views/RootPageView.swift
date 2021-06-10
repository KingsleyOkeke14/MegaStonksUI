//
//  RootPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI
import SwiftKeychainWrapper

struct RootPageView: View {
    
    @EnvironmentObject var userAuth: UserAuth
    
    let pub = NotificationCenter.default.publisher(for: .didAuthTokenExpire)
    
    @State var bannerData:BannerData = BannerData(title: "Authentication Failed", detail: "Your Session has expired and cannot be authenticated at this time. You will be logged out in 6 seconds. Please Login Again", type: .Error)
    
    
    var body: some View {
        if (userAuth.isLoggedin == nil) {
            VStack{
                LoginPageView()
                    .redacted(when: true, redactionType: .customPlaceholder)
                    .preferredColorScheme(.dark)
                Text("Confirming Authentication....")
                    .bold()
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
            }.disabled(true)
        }
        else if(!userAuth.isLoggedin!){
            LoginPageView().preferredColorScheme(.dark)
        }
        else {
            AppPageView()
                .preferredColorScheme(.dark)
                .onAppear(perform: {
                    if(userAuth.isLoggedin == nil && !userAuth.isRefreshingAuth){
                        userAuth.refreshLogin()
                    }
                })
                .banner(data: $bannerData, show: $userAuth.showAuthError)
                .onReceive(pub, perform: { _ in
                    if(!userAuth.isRefreshingAuth){
                        userAuth.refreshLogin()
                    }
                })
                .if(userAuth.isRefreshingAuth){
                    view in
                    view.redacted(when: true, redactionType: .customPlaceholder)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("Moving to the background!")
                    let date = Date()
                    let format = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let timeStamp = format.string(from: date)
                    
                    _ = KeychainWrapper.standard.set(timeStamp, forKey: "sessionTimeStamp")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving to the foreground!")
                    if(userAuth.isLoggedin != nil){
                      userAuth.checkTimeStampForAuth()
                    }
                }
                .environmentObject(userAuth)
        }
    }
}

struct RootPageView_Previews: PreviewProvider {
    static var previews: some View {
        
        RootPageView().environmentObject(UserAuth())
        
    }
}
