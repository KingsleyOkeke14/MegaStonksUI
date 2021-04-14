//
//  LoginPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

struct LoginPageView: View {
    let myColors = MyColors()
    
    @State var emailText:String = ""
    @State var passwordText:String = ""
    @State var errorMessage:String = ""
    
    @State var formText1:String = ""
    @State var formText2:String = ""
    @State var formText3:String = ""
    
    @State var isLoading:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    
    var body: some View {
        NavigationView{
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
              
                VStack{
                    Spacer()
                    Image("megastonkslogo")
                        .scaleEffect(0.8)
                        .aspectRatio(contentMode: .fit)
                    Spacer(minLength: 80)
                    
                    FormView(formField: "Email Address", formText: $emailText)
                    SecretFormView(formField: "Password", secretText: $passwordText)
                    Text(errorMessage)
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                        .foregroundColor(.red)
                        .bold()
                        .padding(.horizontal, 10)
                    
                    Button(action: {
                        isLoading = true
                        if(emailText.isEmpty || passwordText.isEmpty){
                            errorMessage = "Email or Address Field cannot be Empty. Please re-enter credentials"
                        isLoading = false

                        }
                        else{
                            isLoading = true
                            self.userAuth.login(email: emailText, password: passwordText) { authResponse in
                                errorMessage = authResponse.errorMessage
                                isLoading = false
                            }
                            
                        }

                    }, label: {
                        ButtonView(text: "Login")
                            

                    })
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(
                                destination: ForgotPasswordPageView()){
                                Text("Forgot Password?")
                                    .bold()
                                    .foregroundColor(.red)
                                    .underline()
                                    .padding()
                                    .padding(.trailing)
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        NavigationLink(
                            destination: RegisterPageView()){
                            
                            HStack{
                                Spacer()
                                    Text("Register")
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .padding(.trailing)
                            }
                            

                            
                        }
                        

                        Spacer()
                    }


                }.padding()
                .overlay(
                
                    VStack{
                        if(isLoading){
                            LoadingIndicatorView()
                        }

                    
                

                }
                )
            )
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            

            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        }
    
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
