//
//  ContentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

struct FormView: View {
   let myColor = MyColors()
    var formField:String
    @Binding var formText:String
    
    var body: some View {
        VStack(spacing: 0.5){
            HStack{
                Text(formField)
                    .foregroundColor(myColor.greenColor)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                    .bold()
                Spacer()
            }
            TextField("", text: $formText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                .foregroundColor(.white)
                            
            Rectangle()
                .fill(myColor.greenColor)
                 .frame(height: 2)
                 .edgesIgnoringSafeArea(.horizontal)
            
    
        }
        .padding()
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        
        FormView(formField: "Email Address", formText: Binding.constant(""))
            .preferredColorScheme(.dark)
    }
}
