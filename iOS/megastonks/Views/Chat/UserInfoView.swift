//
//  UserInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-27.
//

import SwiftUI

struct UserInfoView: View {
    var user: ChatUserResponse
    var showExitToAppButton: Bool
    @State var showCloseChatprompt: Bool = false
    @State var errorMessage = ""
    @State var isLoading = false
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var chatVm: ChatVM
    @Environment(\.presentationMode) var presentationMode
    
    init(user: ChatUserResponse, showExitToAppButton: Bool){
        self.user = user
        self.showExitToAppButton = showExitToAppButton
    }
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                     VStack {
                         UserImageView(chatUser: user, isMaxSize: true)
                         
                         Text("@\(user.userName)")
                             .font(.custom("Helvetica", fixedSize: 18))
                             .bold()
                             .foregroundColor(.white)
                             .padding(.top)
                         
                         Text("Please remember that your chat name is unique to you and your device. This allows us to maintain your anonymity. If you end this chat session, you will have to select another username")
                             .font(.custom("Helvetica", fixedSize: 14))
                             .bold()
                             .foregroundColor(.gray)
                             .multilineTextAlignment(.center)
                             .padding()
                             .padding(.horizontal, 10)
                         
                         HStack{
                             Button(action: {
                                 
                                 showCloseChatprompt = true
                                 
                             }, label: {
                                 Text("Close Chat Session")
                                     .font(.custom("Helvetica", fixedSize: 20))
                                     .bold()
                                     .foregroundColor(.red)
                                     .padding(2)
                                     .padding(.horizontal, 6)
                             })
                         }.padding()
                         
                         if(showExitToAppButton){
                             Button(action: {
                                 presentationMode.wrappedValue.dismiss()
                                 userAuth.isInChatMode = false
                                 defaults.setValue(false, forKey: "isInChatMode")
                             }, label: {
                                 HStack {
                                     
                                     Image(systemName: "arrow.backward.circle.fill")
                                         .foregroundColor(.green)
                                         .font(.custom("", fixedSize: 22))
                                     
                                     Text("Exit To Main App")
                                         .font(.custom("", fixedSize: 18))
                                         .foregroundColor(.green)
                                         .bold()
                                         .padding(.trailing)
                                     
                                 }.padding()
                             })
                         }
                     }
                     .disabled(showCloseChatprompt)
                     .blur(radius: showCloseChatprompt ? 20 : 0)
                     .overlay(
                         VStack{
                             if(showCloseChatprompt){
                                 VStack(spacing: 40){
                                     Text(errorMessage)
                                         .foregroundColor(.red)
                                         .font(.custom("Helvetica", size: 12))
                                         .bold()
                                         .multilineTextAlignment(.center)
                                     VStack {
                                         Text("Are you sure you will like to close your chat session?")
                                             .font(.custom("Helvetica", fixedSize: 14))
                                             .bold()
                                             .multilineTextAlignment(.center)
                                         Text("By closing the chat session, you will lose access to your chat session and history.")
                                             .font(.custom("Helvetica", fixedSize: 10))
                                             .bold()
                                             .multilineTextAlignment(.center)
                                             .foregroundColor(.white.opacity(0.4))
                                     }
                                     
                                     HStack(spacing: 80){
                                         Button(action: {
                                             self.isLoading = true
                                             chatVm.chatApi.removeDeviceToken(user: user) { result in
                                                 switch result {
                                                 case .success(_):
                                                     ChatUserProfileCache.remove()
                                                     presentationMode.wrappedValue.dismiss()
                                                     userAuth.isChatLoggedIn = false
                                                     userAuth.chatUser = nil
                                                     self.isLoading = false
                                                 case .failure(let error):
                                                     self.isLoading = false
                                                     errorMessage = error.localizedDescription
                                                 }
                                             }
                                             
                                         }, label: {
                                             Text("Yes")
                                                 .font(.custom("Helvetica", fixedSize: 20))
                                                 .bold()
                                                 .foregroundColor(.white)
                                                 .padding()
                                                 .background(Color.gray)
                                                 .cornerRadius(20)
                                             
                                         })
                                         
                                         Button(action: {
                                             errorMessage = ""
                                             showCloseChatprompt = false
                                         }, label: {
                                             Text("No")
                                                 .font(.custom("Helvetica", fixedSize: 20))
                                                 .bold()
                                                 .foregroundColor(.white)
                                                 .padding()
                                                 .background(Color.green)
                                                 .cornerRadius(20)
                                             
                                         })
                                     }
                                 }
                                 .transition(.scale.animation(.easeIn(duration: 0.4)))
                                 .preferredColorScheme(.dark)
                             }
                         }.padding(.horizontal, 20)
                         
                     )
                     .overlay(
                        VStack{
                            if self.isLoading {
                                Color.black.opacity(0.6).overlay(
                                    VStack{
                                        Spacer()
                                        ProgressView()
                                            .accentColor(.green)
                                            .scaleEffect(x: 1.4, y: 1.4)
                                            .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                        Spacer()
                                    }
                                )
                            }
                        }
                       )
                     .onAppear(perform: {
                            errorMessage = ""
                      })
            
            )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(user: ChatUserResponse(id: 1, userName: "KenzoDrizzy", image: "🤩", connectionId: nil, isConsultant: false, lastUpdated: ""), showExitToAppButton: true)
            .environmentObject(UserAuth())
    }
}
