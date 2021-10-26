//
//  ChatHomeView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-04.
//

import SwiftUI

struct ChatHomeView: View {
    var user: ChatUserResponse
    @State var showUserChatOptions: Bool = false
    @State var isLoading: Bool = true
    @State var errorMessage: String = ""
    @StateObject var chatVm = ChatVM()
    @EnvironmentObject var userAuth: UserAuth
    
    init(user: ChatUserResponse) {
        self.user = user
    }
    var body: some View {
                NavigationView {
                    GeometryReader { geometry in
                        VStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 30, style: .circular)
                                    .fill(myColors.greenColor.opacity(0.8))
                                    .edgesIgnoringSafeArea(.horizontal)
                                    
                                    .overlay(
                                        Button(action: {
                                            showUserChatOptions = true
                                            
                                        }, label: {
                                            HStack {
                                                VStack(spacing: 10){
                                                    
                                                    UserImageView(chatUser: user, isMaxSize: true)
                                                    
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
                            if(!isLoading){
                                Text(errorMessage)
                                    .font(.body)
                                    .foregroundColor(.red)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                ScrollView{
                                    VStack(spacing: 0) {
                                        PullToRefreshView(onRefresh:{
                                            self.errorMessage = ""
                                            self.isLoading = true
                                            chatVm.chatConnection.updateConnectionId(user: user)

                                            chatVm.chatApi.fetchFeed(user: user){ result in
                                                switch result {
                                                case .success(let result):
                                                    var newFeed = [ChatFeed]()
                                                    DispatchQueue.main.async {
                                                        result.forEach{ feedResponse in
                                                            newFeed.append(ChatFeed(chatFeedElementResponse: feedResponse))
                                                                                            self.chatVm.feed = newFeed
                                                        }
                                                    }
                                                    self.isLoading = false
                                                case .failure(let error):
                                                    self.errorMessage = error.localizedDescription
                                                    self.isLoading = false
                                                }
                                            }
                                        })
                                    }
                                    if self.chatVm.feed.count != 0 {
                                        LazyVStack{
                                            ForEach(chatVm.feed.indices, id: \.self) { index in
                                                NavigationLink(
                                                    destination:
                                                        ChatView(chatFeedIndex: index)
                                                        .environmentObject(userAuth)
                                                        .environmentObject(chatVm)
                                                    
                                                    ,
                                                    label: {
                                                        ChatCellView(chatFeedIndex: index)
                                                            .environmentObject(chatVm)
                                                    })
                                            }
                                        }
                                    }
                                }
                                    
                            }
                            else{
                                Spacer()
                                ProgressView()
                                    .accentColor(.green)
                                    .scaleEffect(x: 1.4, y: 1.4)
                                    .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                Spacer()
                            }
                        }
                        
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    }
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarHidden(true)
                    .navigationTitle("")
                }
                .sheet(isPresented: $showUserChatOptions, content: {
                    UserInfoView(user: user, showExitToAppButton: userAuth.isInChatMode)
                })
                .onAppear(perform: {
                    chatVm.chatApi.fetchFeed(user: user){ result in
                        switch result {
                        case .success(let result):
                            var newFeed = [ChatFeed]()
                            DispatchQueue.main.async {
                                result.forEach{ feedResponse in
                                    newFeed.append(ChatFeed(chatFeedElementResponse: feedResponse))
                                    self.chatVm.feed = newFeed
                                }
                            }
                            // I have to do this because the SignalR connection is possibly still instanciaiting
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                chatVm.chatConnection.updateConnectionId(user: user)
                            }
                            self.isLoading = false
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            self.isLoading = false
                        }
                    }
                })

    }
}


struct ChatCellView : View {
    
    var chatFeedIndex: Int
    @EnvironmentObject var chatVm: ChatVM
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
                        if let chatFeed = chatVm.feed[chatFeedIndex] {
                            UserImageView(chatUser: chatFeed.user.toChatUserResponse(), isMaxSize: false).padding()
                            VStack(alignment: .leading,spacing: 0){
                                
                                Text(chatFeed.user.userName)
                                    .font(.custom("Helvetica", fixedSize: 16))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.top)
                                
                                if chatFeed.user.isConsultant && chatFeed.sessionId == nil {
                                    Text("Tap to Start Chat")
                                        .font(.custom("Helvetica", fixedSize: 16))
                                        .bold()
                                        .foregroundColor(myColors.greenColor)
                                        .padding(.top)
                                        .minimumScaleFactor(1)
                                    
                                }
                                else {
                                    if let chatMessage = chatFeed.chatMessages?.last {
                                        Text(chatMessage.message)
                                            .font(.custom("Helvetica", fixedSize: 16))
                                            .bold()
                                            .foregroundColor(chatMessage.isReply ? myColors.greenColor : .white)
                                            .padding(.top)
                                            .minimumScaleFactor(1)
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.custom("Helvetica", fixedSize: 16).bold())
                                .foregroundColor(myColors.greenColor)
                                .padding()
                        }
                    }
                )
        }
        .frame(height: 80, alignment: .center)
        .padding(.top, 6)
    }
}


struct ChatHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHomeView(user: ChatUserResponse(id: 1, userName: "kenzoDrizzy", image: "🥳", connectionId: nil, isConsultant: false, lastUpdated: ""))
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}

struct UserImageView : View {
    var chatUser: ChatUserResponse?
    var isMaxSize: Bool
    var body : some View{
        VStack{
            if let chatUser = chatUser {
                if(chatUser.isConsultant){
                    ZStack{
                        Circle()
                            .stroke(myColors.greenColor, lineWidth: 4)
                            .frame(width: isMaxSize ? 100 : 50, height: isMaxSize ? 100 : 50)
                        AsyncImage(url: URL(string: chatUser.image)!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: isMaxSize ? 100 : 50, height: isMaxSize ? 100 : 50, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
                    }
                }
                else{
                    Text(chatUser.image)
                        .font(.custom("", fixedSize: isMaxSize ? 70 : 40))
                        .scaledToFit()
                        .background(
                        
                            ZStack {
                                Circle()
                                    .stroke(myColors.greenColor, lineWidth: 4)
                                    .frame(width: isMaxSize ? 100 : 50, height: isMaxSize ? 100 : 50)
                                
                                Circle()
                                    .fill(myColors.grayColor)
                                    .frame(width: isMaxSize ? 100 : 50, height: isMaxSize ? 100 : 50)
                            }
                        )
                }
            }
        }
    }
}

struct MiniUserImageView : View {
    var chatUser: ChatUserResponse?
    var body : some View{
        VStack{
            if let chatUser = chatUser {
                if(chatUser.isConsultant){
                    AsyncImage(url: URL(string: chatUser.image)!,
                               placeholder: { Image("blackImage") },
                               image: { Image(uiImage: $0).resizable() })
                        .frame(width: 22, height: 22, alignment: .center)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 6)
                }
                else{
                    ZStack {
                        Circle()
                            .stroke(myColors.greenColor, lineWidth: 4)
                            .frame(width: 24, height: 24)
                        
                        Text(chatUser.image)
                            .font(.custom("", fixedSize: 22))
                        
                    }
                }
            }
        }
    }
}
