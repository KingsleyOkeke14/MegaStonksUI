//
//  ContentView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

struct FormView: View {
    let greencolor:Color = Color.init(red: 129/255, green: 182/255, blue: 121/255)
    var formField:String
    @Binding var formText:String
    
    var body: some View {
        VStack(spacing: 0.5){
            HStack{
                Text(formField)
                    .foregroundColor(greencolor)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                    .bold()
                Spacer()
            }
            TextField("", text: $formText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                .foregroundColor(.white)
                
            Rectangle()
                 .fill(greencolor)
                 .frame(height: 2)
                 .edgesIgnoringSafeArea(.horizontal)
            
    
        }.padding()
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        
        FormView(formField: "Email Address", formText: Binding.constant(""))
            .preferredColorScheme(.dark)
    }
}
