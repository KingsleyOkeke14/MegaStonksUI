//
//  ChatView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-25.
//

import SwiftUI

struct ChatView: View {
    
    @State var showUserInfo: Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        VStack(spacing: 0){
            ChatHeaderView()
                .environmentObject(userAuth)
            
            ScrollView(showsIndicators: false){
                Text("Thank you for connecting with me. Send me a message and I will respond as soon as I can")
                    .font(.custom("Helvetica", fixedSize: 10))
                    .bold()
                    .foregroundColor(.white.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                ChatTextCell(showUserInfo: $showUserInfo, image: "😎", isOwnedChat: true)
                ChatTextCell(showUserInfo: $showUserInfo,image: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg", isOwnedChat: false)
                ChatTextCell(showUserInfo: $showUserInfo, image: "😎", isOwnedChat: true)
                ChatTextCell(showUserInfo: $showUserInfo,image: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg", isOwnedChat: false)
                ChatTextCell(showUserInfo: $showUserInfo, image: "😎", isOwnedChat: true)
                ChatTextCell(showUserInfo: $showUserInfo,image: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg", isOwnedChat: false)
            }
            .blur(radius: showUserInfo ? 20 : 0)
            .disabled(showUserInfo)
            .onTapGesture {
                showUserInfo = false
            }
            .overlay(
                VStack{
                    if (showUserInfo){
                        UserInfoView()
                            .transition(.scale.animation(.easeIn(duration: 0.4)))
                    }
                }
            )
            Spacer()
        } .ignoresSafeArea()
        
        
    }
}

struct ChatHeaderView: View{
    
    @State private var showChatOptions = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 30, style: .circular)
                .fill(myColors.lightGrayColor.opacity(0.2))
                .edgesIgnoringSafeArea(.horizontal)
                .frame(height: 140)
                .overlay(
                    Button(action: {
                        showChatOptions.toggle()
                        
                    }, label: {
                        HStack {
                            VStack(spacing: 0){
                                ZStack {
                                    Circle()
                                        .stroke(myColors.greenColor, lineWidth: 4)
                                        .frame(width: 50, height: 50)
                                    AsyncImage(url: URL(string: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg")!,
                                               placeholder: { Image("blackImage") },
                                               image: { Image(uiImage: $0).resizable() })
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .clipShape(Circle())
                                        .aspectRatio(contentMode: .fill)
                                        .shadow(radius: 8)
                                }.padding(.horizontal)
                                
                                Text("Kingsley Okeke")
                                    .font(.custom("Helvetica", fixedSize: 16))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }.offset(x: 0.0, y: 16)
                    })
                    
                    
                )
        }
        .sheet(isPresented: $showChatOptions, content: {
            ChatOptionsView()
                .preferredColorScheme(.dark)
                .environmentObject(userAuth)
            
            
        })
        
    }
}

struct ChatTextCell : View{
    
    @Binding var showUserInfo: Bool
    
    var image: String?
    var isOwnedChat: Bool
    var body: some View {
        HStack(spacing: 10){
            
            if(isOwnedChat){
                HStack(spacing: 4) {
                    Spacer()
                    VStack{
                        
                    }.frame(width: 20)
                    Text("Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know. Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know. Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know.")
                        .font(.custom("Helvetica", fixedSize: 16))
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .background(myColors.greenColor)
                        .cornerRadius(20)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = "Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know. Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know. Hi Kingsley, I had a question regarding my credit cared. How do i reduce the interest rate on it or pay less. Please let me know."
                            }) {
                                Text("Copy")
                                }
                            }
                    
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.custom("", fixedSize: 12))
                        .foregroundColor(myColors.greenColor)
                        
                    Text(image!)
                        .font(.custom("", fixedSize: 22))
                        .onTapGesture {
                            showUserInfo.toggle()
                        }
                }.padding(.top)
            }
            
            else{
                
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.custom("", fixedSize: 12))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: -180))
                        
                    
                    Text("Hi Michael, Sorry to hear that. Thanks for Chatting")
                        .font(.custom("Helvetica", fixedSize: 16))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(myColors.grayColor)
                        .cornerRadius(20)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = "Hi Michael, Sorry to hear that. Thanks for Chatting"
                            }) {
                                Text("Copy")
                                    .font(.custom("", fixedSize: 8))
                                }
                        }
                    
                    VStack{
                        
                    }.frame(width: 20)
                    Spacer()
                }.padding(.top)
            }
            
        }.padding(.horizontal, 2)
        
        
        
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}
