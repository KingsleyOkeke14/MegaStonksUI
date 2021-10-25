//
//  ChatView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-25.
//

import SwiftUI

struct ChatView: View {
    let colors: [Color] = [.red, .green, .blue]
    var chatFeedIndex: Int
    @State var text: String = ""
    @State var height: CGFloat = 40
    @State var keyboardHeight: CGFloat = 0
    @State var isKeyboardVisible: Bool = false
    @State private var showChatOptions = false
    @State var isLoading: Bool = true
    @State var errorMessage: String = ""
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var chatVm: ChatVM
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.custom("Helvetica", size: 12))
                    .bold()
                    .multilineTextAlignment(.center)
                ScrollView(showsIndicators: true){
                    Text("Thank you for connecting with me. Send me a message and I will respond as soon as I can")
                        .font(.custom("Helvetica", fixedSize: 12))
                        .bold()
                        .foregroundColor(.white.opacity(0.4))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                    ScrollViewReader{ value in
                        
                        LazyVStack{
                            if let chatMessages = chatVm.feed[chatFeedIndex].chatMessages {
                                ForEach(chatMessages, id: \.self){ message in
                                    ChatTextCell(user: userAuth.chatUser, chatMessage: message)
                                        .id(message)
                                }
                                .onChange(of: chatMessages, perform: { v in
                                    value.scrollTo(v.last)
                                })
                                .onAppear(perform: {
                                    value.scrollTo(chatMessages.last)
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                                        (data) in
                                        value.scrollTo(chatMessages.last)
                                    }
                                })
                            }
                        }
                    }
                    
                }
                .onAppear{
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                        (data) in
                        let height = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                        self.isKeyboardVisible = true
                        self.keyboardHeight = height.cgRectValue.height - 8
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                        _ in
                        self.isKeyboardVisible = false
                        self.keyboardHeight = 0
                    }
                }
                HStack{
                    Button(action: {
                        hideKeyboard()
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.custom("", size: 20))
                            .foregroundColor(isKeyboardVisible ? myColors.greenColor : myColors.lightGrayColor)
                        
                    })
                    DynamicTextField(text: $text, height: $height)
                        .frame( height: height < 140 ? height : 140)
                        .padding(.horizontal, 4)
                        .background(Blur(style: .light))
                        .cornerRadius(14)
                    
                    
                    
                    
                    Button(action: {
                        print("button tap")
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                        if let chatUser = userAuth.chatUser {
                            if let sessionId = chatVm.feed[chatFeedIndex].sessionId {
                                chatVm.sendMessage(user: chatUser, sessionId: sessionId, message: text){ result in
                                    
                                    switch result {
                                    case .success(_):
                                        print("Successfully Sent Message")
                                    case .failure(let error):
                                        errorMessage = "Could not send message. Please check your internet connection or try again \(error.localizedDescription) "
                                    }
                                }
                            }
                        }

                        text = ""
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.custom("", size: 20))
                            .foregroundColor(text.isEmpty ? myColors.greenColor.opacity(0.6) : myColors.greenColor)
                        
                    })
                    .disabled(text.isEmpty)
                }
                .padding(8)
                .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onEnded({ value in
                                
                                if value.translation.height > 10 {
                                    // down
                                    hideKeyboard()
                                }
                            }))
                .if(userAuth.isInChatMode){ view in
                    view.padding(.bottom, 12)
                        .padding(.bottom, keyboardHeight)
                    
                }
                
            }
            .if(chatVm.feed[chatFeedIndex].user.isConsultant){ view in
                view.sheet(isPresented: $showChatOptions, content: {
                    ChatOptionsView()
                        .preferredColorScheme(.dark)
                        .environmentObject(userAuth)
                })
            }
            .if(userAuth.isInChatMode){ view in
                view.ignoresSafeArea(edges: .bottom)
            }
           .toolbar(content: {
                ToolbarItem(placement: .principal){
                    Button(action: {
                        showChatOptions.toggle()

                    }, label: {
                        HStack {
                            VStack(spacing: 0){
                                ZStack {
                                    Circle()
                                        .stroke(myColors.greenColor, lineWidth: 2)
                                        .frame(width: 30, height: 30)
                                    VStack{
                                        if(chatVm.feed[chatFeedIndex].user.isConsultant){
                                            AsyncImage(url: URL(string: chatVm.feed[chatFeedIndex].user.image)!,
                                                       placeholder: { Image("blackImage") },
                                                       image: { Image(uiImage: $0).resizable() })
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .clipShape(Circle())
                                                .aspectRatio(contentMode: .fill)
                                                .shadow(radius: 8)
                                                .padding(.horizontal)
                                        }
                                        else{
                                                Text(chatVm.feed[chatFeedIndex].user.image)
                                                    .font(.custom("", fixedSize: 24))
                                                    .scaledToFit()
                                                    .background(
                                                        ZStack{
                                                            Circle()
                                                                .stroke(myColors.greenColor, lineWidth: 4)
                                                                .frame(width: 30, height: 30)

                                                            Circle()
                                                                .fill(myColors.grayColor)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                    )
                                                
                                            
                                        }
                                    }
                                }.padding(.horizontal)

                                Text(chatVm.feed[chatFeedIndex].user.userName)
                                    .font(.custom("Helvetica", fixedSize: 12))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(x: 0, y: -6)
                    })
                }
            })
        }
        .onAppear(perform: {
            if chatVm.feed[chatFeedIndex].sessionId == nil && chatVm.feed[chatFeedIndex].user.isConsultant {
                self.isLoading = true
                if let chatUser = userAuth.chatUser {
                    let userToStartChatWith = chatVm.feed[chatFeedIndex].user
                    chatVm.chatApi.startChat(user: chatUser,
                                             userToStartChatWith: ChatUserResponse(id: userToStartChatWith.id, userName: userToStartChatWith.userName, image: userToStartChatWith.image, connectionId: userToStartChatWith.connectionId, isConsultant: userToStartChatWith.isConsultant, lastUpdated: userToStartChatWith.lastUpdated)){
                        result in
                        switch result {
                        case .success(let chatSession):
                            DispatchQueue.main.async {
                                chatVm.feed[chatFeedIndex].sessionId = chatSession.id
                            }
                            self.isLoading = true
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.errorMessage = error.localizedDescription
                            }
                            self.isLoading = true
                        }
                    }
                }
            }
        })
        .onDisappear{
            guard let chatUser = self.userAuth.chatUser else {return}
            self.chatVm.updateFeed(user: chatUser)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatTextCell : View{
    
    
    
    var user: ChatUserResponse?
    var chatMessage: ChatMessage
    
    var body: some View {
        HStack(spacing: 10){
            
            if(!chatMessage.isReply){
                HStack(spacing: 4) {
                    Spacer()
                    VStack{
                        
                    }.frame(width: 20)
                    VStack(alignment: .trailing) {
                        Text(chatMessage.message)
                                .font(.custom("Helvetica", fixedSize: 16))
                                .bold()
                                .foregroundColor(.white)
                        
                        
                        Text(chatMessage.timeStamp)
                            .font(.custom("Helvetica", fixedSize: 10))
                            .foregroundColor(.white.opacity(0.7))
                            .bold()
                            .italic()
                            .padding(.bottom, 6)
                    }
                    .padding([.top, .horizontal])
                    .background(myColors.greenColor)
                    .cornerRadius(20)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = chatMessage.message
                        }) {
                            Text("Copy")
                        }
                    }
                    
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.custom("", fixedSize: 12))
                        .foregroundColor(myColors.greenColor)
                    
                    MiniUserImageView(chatUser: user)
                }.padding(.top)
            }
            
            else{
                
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.custom("", fixedSize: 12))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: -180))
                    
                    
                    VStack(alignment: .leading) {
                            Text(chatMessage.message)
                                .font(.custom("Helvetica", fixedSize: 16))
                                .bold()
                                .foregroundColor(myColors.greenColor)

                            Text(chatMessage.timeStamp)
                                .font(.custom("Helvetica", fixedSize: 10))
                                .foregroundColor(.gray)
                                .bold()
                                .italic()
                                .padding(.bottom, 6)
                                .alignmentGuide(.trailing) { d in d[.leading] }
                        
                    }
                    .padding([.top, .horizontal])
                    .background(myColors.grayColor)
                    .cornerRadius(20)
                    
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = chatMessage.message
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
//        ChatView()
//            .preferredColorScheme(.dark)
//            .environmentObject(UserAuth())
        
        ChatHomeView(user: ChatUserResponse(id: 1, userName: "kenzoDrizzy", image: "🥳", connectionId: nil, isConsultant: false, lastUpdated: ""))
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}
