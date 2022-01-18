//
//  CryptoPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-15.
//

import SwiftUI

struct CryptoPageView: View {
    var body: some View {
        Color.megaStonksDarkGreen
            .ignoresSafeArea()
            .overlay(
                VStack {
                    headerView()
                    Spacer()
                }
            )
    }
    
    @ViewBuilder
    func headerView() -> some View  {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/2010.png")!, placeholder: {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                })
                .frame(dimension: 60)

                Group {
                    Text("Cardano")
                        .font(.custom("Poppins-SemiBold", fixedSize: 34))
                    Text("ADA")
                        .font(.custom("Poppins-Regular", fixedSize: 16))
                        .padding(2)
                        .offset(y: 6)
                }
                .foregroundColor(.white)
                Spacer()
            }
            Text("$1.346")
                .font(.custom("Poppins-SemiBold", fixedSize: 17))
                .foregroundColor(Color.white)
                .offset(y: -8)
        }
    }
}

struct CryptoPageView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoPageView()
    }
}
