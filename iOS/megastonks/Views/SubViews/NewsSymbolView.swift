//
//  NewsSymbolView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-10.
//

import SwiftUI

struct NewsSymbolView: View {
    let myColors = MyColors()
    
    var newsElement:NewsElement
    
    
    var body: some View {
        VStack(spacing: 2){
            HStack{
                LazyVStack{
                    AsyncImage(url: URL(string: newsElement.image)!,
                               placeholder: { Image("blackImage") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                        .opacity(0.6)
                }.frame(width: 80, height: 80, alignment: .center)
                VStack(spacing: 8){
                    HStack{
                        Text(newsElement.symbol)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                            .bold()
                            .foregroundColor(myColors.greenColor)
                            .lineLimit(1)
                        Spacer()
                    }
                    HStack{
                        Text(newsElement.title)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(2)
                       Spacer()
                    }
                    HStack{
                        Spacer()
                        Text(newsElement.site)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 10))
                            .bold()
                            .foregroundColor(.gray)
                            .lineLimit(2)
                       
                    }.padding(.horizontal)

                }
            }
            Rectangle()
                .fill(Color(.gray))
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct NewsSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSymbolView(newsElement: StockSymbolModel().newsModel).preferredColorScheme(.dark)
    }
}
