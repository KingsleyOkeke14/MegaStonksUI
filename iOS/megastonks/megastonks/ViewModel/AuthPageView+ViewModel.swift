//
//  AuthPageView+ViewModel.swift
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
        
        enum RegisterMode {
            case email
            case password
        }
        
        //Login Model
        @Published var emailLogin = ""
        @Published var passwordLogin = ""
        
        //Registration Model
        @Published var userNameRegister = ""
        @Published var emailRegister = ""
        @Published var passwordRegister = ""
        @Published var confirmPasswordRegister = ""
        @Published var didOpenTerms: Bool = false
        @Published var didAcceptTerms: Bool = false
        
        
        @Published var confirmPasswordText = ""
        @Published var errorMessage = ""
        @Published var mode: Mode = .login
        @Published var registerMode: RegisterMode = .email
        
        func setMode(mode: ViewModel.Mode) {
            self.mode = mode
            if mode == .login {
                self.registerMode = .email
            }
        }
        
        func setRegisterMode(mode: ViewModel.RegisterMode) {
            self.registerMode = mode
        }
    }
}
