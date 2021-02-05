//
//  SearchBarView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-02.
//

import SwiftUI

struct SearchBarView: View {
    
    let grayColor:Color = Color.init(red: 26/255, green: 25/255, blue: 27/255)
    let lightGrayColor:Color = Color.init(red: 88/255, green: 87/255, blue: 92/255)
    
    @Binding var text:String
    var body: some View {
        HStack{
            TextField("Search Stock Ticker Symbol", text: $text)
                .padding()
                .padding(.horizontal, 24)
                .background(grayColor)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .cornerRadius(20)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(lightGrayColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                    }
                
                )
        }.padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: Binding.constant(""))
            .preferredColorScheme(.dark)
        SearchBarView(text: Binding.constant(""))
    }
}
