//
//  ChatView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-25.
//

import SwiftUI

struct ChatView: View {
    let colors: [Color] = [.red, .green, .blue]
    @State var showUserInfo: Bool = false
    @State var text: String = ""
    @State var height: CGFloat = 40
    @State var keyboardHeight: CGFloat = 0
    @State var isKeyboardVisible: Bool = false
    
    @StateObject var chatVM: ChatVM = ChatVM()
    
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ChatHeaderView()
                    .frame(height: 140)
                    .environmentObject(userAuth)
                
                
                ScrollView(showsIndicators: true){
                    Text("Thank you for connecting with me. Send me a message and I will respond as soon as I can")
                        .font(.custom("Helvetica", fixedSize: 12))
                        .bold()
                        .foregroundColor(.white.opacity(0.4))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(6)
                    ScrollViewReader{ value in
                        
                        LazyVStack{
                            ForEach(chatVM.messages, id: \.self){ message in
                                ChatTextCell(message: message.message, isOwnedMessaged: !message.isReply, showUserInfo: $showUserInfo)
                                    .id(message)
                            }
                            .onChange(of: chatVM.messages, perform: { v in
                                value.scrollTo(v.last)
                            })
                            .onAppear(perform: {
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                                    (data) in
                                    value.scrollTo(chatVM.messages.last)
                                }
                            })
                        }
                    }
                    
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
                                .transition(.scale.animation(.easeIn(duration: 0.6)))
                        }
                    }
                )
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
                        chatVM.sendMessage(user: "Kingsley", message: text)
                        text = ""
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.custom("", size: 20))
                            .foregroundColor(text.isEmpty ? myColors.greenColor.opacity(0.6) : myColors.greenColor)
                        
                    })
                    .disabled(text.isEmpty)
                }
                .padding(8)
                .padding(.bottom, 12)
                .padding(.bottom, keyboardHeight)
                .background(Blur(style: .dark))
                .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onEnded({ value in
                                
                                if value.translation.height > 10 {
                                    // down
                                    hideKeyboard()
                                }
                            }))
                
            }.ignoresSafeArea()
        }
        
        
        
    }
}

struct ChatHeaderView : View{
    
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
    
    
    
    var message: String
    var image: String? = "😎"
    var isOwnedMessaged: Bool
    
    @Binding var showUserInfo: Bool
    
    var body: some View {
        HStack(spacing: 10){
            
            if(isOwnedMessaged){
                HStack(spacing: 4) {
                    Spacer()
                    VStack{
                        
                    }.frame(width: 20)
                    VStack(alignment: .trailing) {
                        Text(message)
                            .font(.custom("Helvetica", fixedSize: 16))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("5m ago")
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
                            UIPasteboard.general.string = message
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
                    
                    
                    VStack(alignment: .trailing) {
                        Text(message)
                            .font(.custom("Helvetica", fixedSize: 16))
                            .bold()
                            .foregroundColor(.white)
                        Text("5m ago")
                            .font(.custom("Helvetica", fixedSize: 10))
                            .foregroundColor(.gray)
                            .bold()
                            .italic()
                            .padding(.bottom, 6)
                    }
                    .padding([.top, .horizontal])
                    .background(myColors.grayColor)
                    .cornerRadius(20)
                    
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = message
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
