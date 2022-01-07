//
//  AuthPage+ViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-06.
//

import Foundation

extension AuthPageView {
    @MainActor class ViewModel: ObservableObject {
        
        enum Mode {
            case loading
            case login
            case register
            case forgotPassword
        }
        
        @Published var emailText = ""
        @Published var passwordText = ""
        @Published var errorMessage = ""
        @Published var mode: Mode = .login
    }
}
