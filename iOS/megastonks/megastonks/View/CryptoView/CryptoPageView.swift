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
                AsyncImage(url: URL(string: "https://w7.pngwing.com/pngs/844/873/png-transparent-cardano-zug-cryptocurrency-blockchain-ethereum-bitcoin-wallet-thumbnail.png")!, placeholder: {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                })

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
