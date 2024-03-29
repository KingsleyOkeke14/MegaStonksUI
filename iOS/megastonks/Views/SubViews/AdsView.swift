//
//  AdsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-04.
//

import SwiftUI

struct AdsView: View {
    
    let myColors = MyColors()
    @State var currentIndex:Int = 0
    
    
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    var showRandomAd: Bool = false
    
    @State var randomAd:Int = 0
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var myAppObjects:AppObjects
    
    
    
    var body: some View {
        if(myAppObjects.ads.count > 1 && !showRandomAd){
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<myAppObjects.ads.count, id: \.self) { d in
                  
                    HStack{
                        VStack {
                            
                            AsyncImage(url: URL(string: myAppObjects.ads[d].imageUrl)!,
                                          placeholder: { Image("blackImage") },
                                          image: { Image(uiImage: $0).resizable() })
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.green, lineWidth: 2))
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 8)
                                .opacity(0.6)
                            
                        }
                        VStack(alignment: .leading, spacing: 10){
                            Text(myAppObjects.ads[d].title)
                                .font(.custom("Verdana", fixedSize: 16))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                            Text(myAppObjects.ads[d].description)
                                .font(.custom("Verdana", fixedSize: 12))
                                .foregroundColor(.white)
                                .lineLimit(3)
                                .minimumScaleFactor(0.5)
                                .padding(.trailing)
                        }
                        Spacer()
                    }//.tag(currentIndex)
                    .onTapGesture(perform: {
                        openURL(URL(string: myAppObjects.ads[currentIndex].urlToLoad)!)
                    })
                    .cornerRadius(24)
                    }.background(Color.black)
            }.onReceive(self.timer, perform: { _ in
                withAnimation(.easeInOut(duration: 2)) {
                    if(currentIndex != myAppObjects.ads.count - 1){
                        currentIndex += 1
                    }
                    else{
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
            .frame(height: 80, alignment: .center)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        else if (myAppObjects.ads.count == 1 && !showRandomAd){
            HStack{
                VStack {
                    
                    AsyncImage(url: URL(string: myAppObjects.ads[0].imageUrl)!,
                                  placeholder: { Image("blackImage") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.green, lineWidth: 2))
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                        .opacity(0.6)
                    
                }
                VStack(alignment: .leading, spacing: 10){
                    Text(myAppObjects.ads[0].title)
                        .font(.custom("Verdana", fixedSize: 16))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(myAppObjects.ads[0].description)
                        .font(.custom("Verdana", fixedSize: 12))
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .padding(.trailing)
                }
                Spacer()
            }
            .onTapGesture(perform: {
                openURL(URL(string: myAppObjects.ads[currentIndex].urlToLoad)!)
            })
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.green, lineWidth: 2)
                    .shadow(color: .green, radius: 4, x: 1, y: 4)
            ).cornerRadius(24)
            .padding(.horizontal, 20)
            .cornerRadius(24)
            .frame(height: 80, alignment: .center)
        }
        
        else if (showRandomAd && !myAppObjects.ads.isEmpty){
            HStack{
                VStack {
                    
                    AsyncImage(url: URL(string: myAppObjects.ads[myAppObjects.randomAdIndex].imageUrl)!,
                                  placeholder: { Image("blackImage") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.green, lineWidth: 2))
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                        .opacity(0.6)
                    
                }
                VStack(alignment: .leading, spacing: 10){
                    Text(myAppObjects.ads[myAppObjects.randomAdIndex].title)
                        .font(.custom("Verdana", fixedSize: 16))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(myAppObjects.ads[myAppObjects.randomAdIndex].description)
                        .font(.custom("Verdana", fixedSize: 12))
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .padding(.trailing)
                }
                Spacer()
            }
            .onDisappear(perform: {
                myAppObjects.updateRandomAdIndex()
            })
            .onTapGesture(perform: {
                openURL(URL(string: myAppObjects.ads[myAppObjects.randomAdIndex].urlToLoad)!)
            })
            .cornerRadius(24)
            .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.green, lineWidth: 2)
                        .shadow(color: .green, radius: 4, x: 1, y: 4)
                    

            ).cornerRadius(24)
            .padding(.horizontal, 20)
            .cornerRadius(24)
            .frame(height: 80, alignment: .center)
        }
    }
}

struct AdsView_Previews: PreviewProvider {
    static var previews: some View {
        AdsView(showRandomAd: false).environmentObject(AppObjects()).preferredColorScheme(.dark)
    }
}
