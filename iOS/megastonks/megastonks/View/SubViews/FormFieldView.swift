//
//  FormFieldView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-06.
//

import SwiftUI

struct FormFieldView: View {
    let formTitle: String
    let defaultText: String = ""
    var isSecureField: Bool = false
    @Binding var formText: String
    var body: some View {
        VStack(spacing: 10) {
            Text(formTitle)
                .font(.custom("Poppins-Regular", fixedSize: 16))
                .foregroundColor(.megaStonksOffWhite)
            HStack {
                if isSecureField {
                    SecureField(defaultText, text: $formText)
                }
                else {
                    TextField(defaultText, text: $formText)
                }
            }
            .font(.custom("Poppins-SemiBold", fixedSize: 14))
            .foregroundColor(.white)
            
            Rectangle()
                .fill(Color.megaStonksLightGray)
                .frame(height: 1)
                .padding(.top, -8)
        }
    }
}

struct FormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FormFieldView(formTitle: "Email Address", formText: Binding.constant(""))
            .preferredColorScheme(ColorScheme.dark)
    }
}
