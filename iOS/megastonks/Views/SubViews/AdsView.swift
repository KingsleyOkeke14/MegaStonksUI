//
//  AdsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-04.
//

import SwiftUI

struct AdsView: View {
    @State var currentIndex:Int = 0
    
    @State var adData:[AdData] = StockSymbolModel().adData
    
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    @Environment(\.openURL) var openURL
    
    var body: some View {
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<adData.count, id: \.self) { d in
                  
                    HStack{
                        VStack {
                            
                            AsyncImage(url: URL(string: adData[d].imageUrl)!,
                                          placeholder: { Text("Loading ...") },
                                          image: { Image(uiImage: $0).resizable() })
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.green, lineWidth: 2))
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 8)
                                .opacity(0.6)
                            
                        }
                        VStack(alignment: .leading, spacing: 10){
                            Text(adData[d].title)
                                .font(.custom("Verdana", fixedSize: 20))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            Text(adData[d].description)
                                .font(.custom("Verdana", fixedSize: 12))
                                .foregroundColor(.white)
                                .lineLimit(3)
                                .minimumScaleFactor(0.5)
                                .padding(.trailing)
                        }
                        Spacer()
                    }//.tag(currentIndex)
                    .onTapGesture(perform: {
                        openURL(URL(string: adData[currentIndex].urlToLoad)!)
                    })
                    .cornerRadius(24)
                    }.background(Color.black)
            }.onReceive(self.timer, perform: { _ in
                withAnimation(.easeInOut(duration: 2)) {
                    if(currentIndex != adData.count - 1){
                        currentIndex += 1
                    }
                    else{
                        adData.shuffle()
                        currentIndex = 0
                    }
                }
            })
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.green, lineWidth: 2)
                    .shadow(color: .green, radius: 4, x: 1, y: 4)
            ).cornerRadius(24)
            .padding(.horizontal, 20)
            .cornerRadius(24)
            .frame(height: 100, alignment: .center)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

    }
}

struct AdsView_Previews: PreviewProvider {
    static var previews: some View {
        AdsView().preferredColorScheme(.dark)
    }
}
