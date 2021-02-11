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
    
    var body: some View {
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack{
                    Spacer()
                    Image("megastonkslogo")
                        .scaleEffect(0.8)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    FormView(formField: "Email Address", formText: $emailText)
                    SecretFormView(formField: "Password", secretText: $passwordText)
                    Button(action: {
                        
                    }, label: {
                        ButtonView(text: "Login")
                            

                    })
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Forgot Password?")
                                .bold()
                                .foregroundColor(.red)
                                .underline()
                                .padding()
                                .padding(.trailing)
                        })
                    }
                    
                    HStack{
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Register")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.trailing)
                        })
                    }
                    Spacer()

                }.padding()
            )
        
        
        
        
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
