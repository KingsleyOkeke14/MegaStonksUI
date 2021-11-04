//
//  ChatRootView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-28.
//

import SwiftUI

struct ChatRootView: View {
    var showExitButton: Bool
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        if(userAuth.isChatLoggedIn){
            if let chatUser = ChatUserProfileCache.get() {
                ChatHomeView(user: chatUser)
            }
        }
        else{
            ChatRegisterView(showExitButton: showExitButton)
        }
    }
}

struct ChatRootView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRootView(showExitButton: false)
    }
}
