//
//  UserInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-27.
//

import SwiftUI

struct UserInfoView: View {
    var userImage: String
    var showExitToAppButton: Bool
    @State var showCloseChatprompt: Bool = false
    @EnvironmentObject var userAuth: UserAuth
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                     VStack {
                         ZStack {
                             Circle()
                                 .stroke(myColors.greenColor, lineWidth: 4)
                                 .frame(width: 100, height: 100)
                             
                             Circle()
                                 .fill(Color.green.opacity(0.1))
                                 .frame(width: 100, height: 100)
                             
                             Text(userImage)
                                 .font(.custom("", fixedSize: 70))
                                 .offset(y: 3)
                             
                         }
                         
                         Text("@KenzoDrizzy")
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
                                             presentationMode.wrappedValue.dismiss()
                                             userAuth.isChatLoggedIn = false
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
            
            
            )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(userImage: "👨‍🦰", showExitToAppButton: true)
            .environmentObject(UserAuth())
    }
}
