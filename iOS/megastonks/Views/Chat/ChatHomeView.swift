//
//  ChatHomeView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-04.
//

import SwiftUI

struct ChatHomeView: View {
    var user: ChatUser
    @State var showUserChatOptions: Bool = false
    @EnvironmentObject var userAuth: UserAuth

    init(user: ChatUser) {
        self.user = user
    }
    var body: some View {
                NavigationView{
                    GeometryReader { geometry in
                        VStack{
                            HStack {
                                RoundedRectangle(cornerRadius: 30, style: .circular)
                                    .fill(myColors.greenColor.opacity(0.8))
                                    .edgesIgnoringSafeArea(.horizontal)
                                    
                                    .overlay(
                                        Button(action: {
                                            showUserChatOptions = true
                                            
                                        }, label: {
                                            HStack {
                                                VStack(spacing: 0){
                                                    ZStack {
                                                        Circle()
                                                            .stroke(myColors.greenColor, lineWidth: 4)
                                                            .frame(width: 100, height: 100)
                                                        
                                                        Circle()
                                                            .fill(myColors.grayColor)
                                                            .frame(width: 100, height: 100)
                                                        
                                                        Text(user.image)
                                                            .font(.custom("", fixedSize: 70))
                                                            .offset(y: 3)
                                                            .opacity(1.0)
                                                        
                                                    }
                                                    
                                                    Text("@\(user.userName)")
                                                        .font(.custom("Helvetica", fixedSize: 16))
                                                        .bold()
                                                        .foregroundColor(.white)
                                                }
                                            }.offset(x: 0.0, y: 16)
                                        }
                                        )
                                    )
                            }
                            .frame(height: 180)
                            
                            ScrollView{
                                NavigationLink(
                                    destination:
                                        ChatView()
                                        .environmentObject(userAuth)
                                    
                                    ,
                                    label: {
                                        ChatCellView()
                                    })
                            }
                            
                            Spacer()
                        }
                        
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    }
                    .ignoresSafeArea()
                    .navigationBarHidden(true)
                    .navigationTitle("")
                }
                .sheet(isPresented: $showUserChatOptions, content: {
                    UserInfoView(user: user, showExitToAppButton: userAuth.isInChatMode)
                })

    }
}


struct ChatCellView : View {
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0), lineWidth: 1)
                    
                )
                .foregroundColor(myColors.lightGrayColor.opacity(0.2))
                .overlay(
                    HStack{
                        AsyncImage(url: URL(string: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg")!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
                            .padding(.horizontal)
                        VStack(alignment: .leading,spacing: 0){
                            
                            Text("Kingsley Okeke")
                                .font(.custom("Helvetica", fixedSize: 16))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top)
                            
                            
                            Text("Hi there, Thank you for checking in. I appreciate the effort")
                                .font(.custom("Helvetica", fixedSize: 16))
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .padding(.top)
                                .minimumScaleFactor(1)
                            Spacer()
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.custom("Helvetica", fixedSize: 16).bold())
                            .foregroundColor(myColors.greenColor)
                            .padding()
                    }
                )
        }
        .frame(height: 80, alignment: .center)
        .padding(.top, 6)
    }
}


struct ChatHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHomeView(user: ChatUser(id: 1, userName: "kenzoDrizzy", image: "🥳", connectionId: nil, isConsultant: false, lastUpdated: ""))
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}
