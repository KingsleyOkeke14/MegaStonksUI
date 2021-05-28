//
//  CryptoInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-18.
//

import SwiftUI

struct CryptoInfoView: View {
    let myColors = MyColors()
    var body: some View {
        HStack{
            VStack(spacing: 2){
                ZStack{
                    Circle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.green, radius: 6, x: 4, y: 4)
                    AsyncImage(url: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png")!,
                               placeholder: { Image("blackImage") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                }
                   
                
                Text("(BTC) Bitcoin")
                    .font(.custom("Helvetica", fixedSize: 18))
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
                HStack {
                    Text("54000.80")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 24))
                        .bold()
                        +
                        Text(" \("USD")")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 16))
                        .bold()
                        .baselineOffset(0)
                    
                }
                
            }
        }
    }
}

struct CryptoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoInfoView().preferredColorScheme(.dark)
    }
}
