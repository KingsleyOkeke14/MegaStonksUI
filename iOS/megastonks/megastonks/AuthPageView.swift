//
//  LoginPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-12-26.
//

import SwiftUI

struct AuthPageView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Color.megaStonksDarkGreen
            .ignoresSafeArea()
            .overlay(
                ScrollView {
                    VStack(spacing: 0) {
                        Image("logo")
                            .resizable()
                            .frame(width: 260, height: 260)
                        
                        VStack(spacing: 30) {
                            FormFieldView(formTitle: "Email Address", formText: $viewModel.emailText)
                            FormFieldView(formTitle: "Password", isSecureField: true, formText: $viewModel.passwordText)
                            Text(viewModel.errorMessage)
                                .font(.custom("Poppins-Regular", fixedSize: 14))
                                .foregroundColor(.megaStonksRed)
                                .padding(-20)
                                .lineLimit(2)
                            Button (action: {}) {
                                button(text: "Login")
                            }
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        
                        VStack(spacing: 10) {
                            Button(action: {}) {
                                Text("Forgot Password?")
                                    .font(.custom("Poppins-Regular", fixedSize: 14))
                                    .foregroundColor(.megaStonksRed)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            Button(action: {}) {
                                Text("Register")
                                    .font(.custom("Poppins-Regular", fixedSize: 16))
                                    .foregroundColor(.megaStonksOffWhite)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.top, 8)
                        .padding()
                        
                        Spacer()
                    }
                }
            )
    }
    
    @ViewBuilder
    func button(text: String, fontSize: CGFloat = 18) -> some View {
        Text(text)
            .font(.custom("Poppins-SemiBold", fixedSize: fontSize))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 24)
            .background(Color.megaStonksLightGreen)
            .cornerRadius(20)
    }
}

struct AuthPageView_Previews: PreviewProvider {
    static var previews: some View {
        AuthPageView()
    }
}
