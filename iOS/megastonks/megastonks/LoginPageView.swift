//
//  LoginPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-12-26.
//

import SwiftUI

struct LoginPageView: View {
    let textOpacity = 0.6
    @State var emailAddressText = ""
    @State var passwordText = ""
    var body: some View {
        Color.megaStonksDarkGreen
            .ignoresSafeArea()
            .overlay(
                ScrollView {
                    VStack(spacing: 0) {
                       Image("logo")
                            .resizable()
                            .frame(width: 300, height: 300)
                        VStack(spacing: 0) {
                            Text("Email Address")
                                .font(.custom("Poppins-Regular", fixedSize: 16))
                                .foregroundColor(.white.opacity(textOpacity))
                            TextField("", text: $emailAddressText)
                                .font(.custom("Poppins-SemiBold", fixedSize: 14))
                                .foregroundColor(.white)
                            Rectangle()
                                .fill(Color.megaStonksLightGray)
                                .frame(height: 1)
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        VStack(spacing: 0) {
                            Text("Password")
                                .font(.custom("Poppins-Regular", fixedSize: 16))
                                .foregroundColor(.white.opacity(textOpacity))
                            TextField("", text: $passwordText)
                                .font(.custom("Poppins-Regular", fixedSize: 14))
                                .foregroundColor(.white)
                            Rectangle()
                                .fill(Color.megaStonksLightGray)
                                .frame(height: 1)
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        Button (action: {}) {
                            Text("Login")
                                .font(.custom("Poppins-SemiBold", fixedSize: 18))
                                .foregroundColor(.white.opacity(textOpacity))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 24)
                                .background(Color.megaStonksLightGreen)
                                .cornerRadius(20)
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                }
        )
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
