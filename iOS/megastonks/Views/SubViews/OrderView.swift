//
//  OrderView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-13.
//

import SwiftUI

struct OrderView: View {
    let myColors = MyColors()
    var body: some View {
                VStack(spacing: 2){
                    HStack{
                        Text("ARKF")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 20))
                            .bold()
                        Text("ARK ETF TR FINTECH INNOVATION ETF")
                            .font(.custom("Verdana", fixedSize: 10))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack{
                        Text("Buy 2000 shares x $2000")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 16))
                        Spacer()
                        Text("@Market")
                            .foregroundColor(myColors.lightGrayColor)
                            .font(.custom("Verdana", fixedSize: 16))
                            
                    }
                    HStack{
                        Spacer()
                        Text("$43,000,000")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 16))
                    }
                    
                    HStack{
                        Text("Executed")
                            .foregroundColor(myColors.greenColor)
                            .font(.custom("Verdana", fixedSize: 12))
                        Spacer()
                        Text("02/02/21 10:07AM")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 12))
                    }
                    Rectangle()
                        .fill(Color(.gray))
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                }.padding(.horizontal)
            
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
