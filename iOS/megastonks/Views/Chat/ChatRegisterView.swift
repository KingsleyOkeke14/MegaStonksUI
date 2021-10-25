//
//  ChatRegisterView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-23.
//

import SwiftUI

struct ChatRegisterView: View {
    var showExitButton: Bool
    let myColors = MyColors()
    @State private var displayName: String = ""
    @State private var error: String = ""
    @State private var isLoading: Bool = false

    @State private var showImagePicker = false
    @State private var showAdminLogin = false
    @State private var showImagePickerHint: Bool = true
    @State private var showSignUpHint: Bool = false
    
    @State var imageOptions: [ProfileImageOption] = ProfileImageOptions().options
    @EnvironmentObject var userAuth: UserAuth

    init(showExitButton: Bool){
        self.showExitButton = showExitButton
    }
    
    var body: some View {
        VStack{
                VStack{
                    Spacer()
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                        showImagePickerHint = false
                        showImagePicker.toggle()
                        
                    }, label: {
                        ZStack {
                            Circle()
                                .stroke(myColors.greenColor, lineWidth: 4)
                                .frame(width: 100, height: 100)
                            
                            Circle()
                                .fill(Color.green.opacity(0.1))
                                .frame(width: 100, height: 100)
                            
                            Text(imageOptions.first(where: { $0.isSelected })?.image ?? "")
                                .font(.custom("", fixedSize: 70))
                                .offset(y: 3)
                                .opacity(showImagePickerHint ? 0.2 : 1.0)
                            
                            if(showImagePickerHint){
                                Image(systemName: "plus.circle")
                                    .foregroundColor(myColors.greenColor)
                                    .font(.custom("", fixedSize: 24))
                            }
                        }
                    })
                
                    
                    FormView(formField: "Display Name", formText: $displayName)
                    
                    Text(error)
                        .font(.custom("", fixedSize: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding()
                    
                    HStack {
                        if(showSignUpHint){
                            Text("Please select a unique display name. This display name will be linked to your chat session. This ensures anonymity")
                                .font(.custom("", fixedSize: 12))
                                .foregroundColor(myColors.greenColor)
                                .padding(8)
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                                .opacity(0.8)
                        }

                            
                        Spacer()
                        Button(action: {
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            showSignUpHint.toggle()
                            
                        }, label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("", fixedSize: 22))
                            
                        })
                    }
                    .frame(height: 60)
                    .padding()
                    
                    Button(action: {
                        if showImagePickerHint {
                           error = "Please select a display image to proceed"
                        }
                        else if !isUserNameValid(username: displayName).0 {
                            error = isUserNameValid(username: displayName).1
                        }
                        else{
                            
                            isLoading = true
                            
                            ChatAPI.shared.createUser(userName: displayName, userImage: imageOptions.first(where: {$0.isSelected})?.image ?? ""){
                                result in
                               
                                switch result{

                                case .success(let user):
                                    ChatUserProfileCache.save(user)
                                    DispatchQueue.main.async {
                                        self.isLoading = false
                                        userAuth.chatUser = user
                                        userAuth.isChatLoggedIn = true
                                    }
                                case .failure(let error):
                                    DispatchQueue.main.async {
                                        self.isLoading = false
                                        self.error = error.localizedDescription
                                    }
                                }



                            }
                          
                        }
                       
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Proceed To Chat")
                                .font(.custom("", fixedSize: 18))
                                .foregroundColor(myColors.greenColor)
                                .bold()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("", fixedSize: 22))
                                .padding(.trailing)
                        }
                    })
                    
                    Spacer()
                    if(showExitButton){
                        Button(action: {
                            userAuth.isInChatMode = false
                            defaults.setValue(false, forKey: "isInChatMode")
                        }, label: {
                            HStack {
                                
                                Image(systemName: "arrow.backward.circle.fill")
                                    .foregroundColor(myColors.redColor)
                                    .font(.custom("", fixedSize: 22))
                                    
                                Text("Exit To Main App")
                                    .font(.custom("", fixedSize: 18))
                                    .foregroundColor(myColors.redColor)
                                    .bold()
                                    .padding(.trailing)

                            }
                        })
                    }
                    Spacer()
                }
                .onTapGesture {
                    showSignUpHint = false
                }
                .onLongPressGesture(minimumDuration: 6, perform: {
                    self.showAdminLogin = true
                })
                .sheet(isPresented: $showImagePicker) {
                    ProfileImagePickerView(imageOptions: $imageOptions).preferredColorScheme(.dark)
                }
                .sheet(isPresented: $showAdminLogin) {
                    AdminLoginView().environmentObject(userAuth)
                }
        }
        .disabled(isLoading)
        .blur(radius: isLoading ? 2 : 0)
        .overlay(
            VStack{
                if isLoading {
                    LoadingIndicatorView()
                }
            }
        )
    }
}

func isUserNameValid(username: String) -> (Bool, String) {
    if username.containsWhiteSpace() {
        return (false, "Display Name cannot cotain white spaces")
    }
    else{
        if let _ =  username.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression){
               return (false, "Special Characters are not allowed")
            }
        return (true, "")
    }
}

struct AdminLoginView: View {
    @State var authCode: String = ""
    @State var error: String = ""
    @State var isLoading = false
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        Color.black.ignoresSafeArea()
            .overlay(
                VStack{
                    if isLoading {
                        VStack{
                            LoadingIndicatorView()
                        }
                    }
                    else{
                        VStack{
                            FormView(formField: "Enter Auth Code", formText: $authCode)
                            Text(error)
                                .font(.title2)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                            Button(action: {
                                self.isLoading = true
                                ChatAPI.shared.getAdmin(authCode: authCode){
                                    result in
                                    
                                    switch result{
                                        
                                    case .success(let user):
                                        ChatUserProfileCache.save(user)
                                        DispatchQueue.main.async {
                                            self.isLoading = false
                                            userAuth.chatUser = user
                                            userAuth.isChatLoggedIn = true
                                        }
                                    case .failure(let error):
                                        DispatchQueue.main.async {
                                            self.isLoading = false
                                            self.error = error.localizedDescription
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }, label: {
                                Text("Login")
                                    .font(.title2)
                                    .foregroundColor(myColors.greenColor)
                            })
                        }
                    }
                }
            )
    }
}

struct ChatRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRegisterView(showExitButton: true)
            .environmentObject(UserAuth())
            .preferredColorScheme(.dark)
    }
}
