//
//  OnBoardPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct OnBoardPageView: View {
    @State var selectedPage:Int = 0
    
    @EnvironmentObject var userAuth: UserAuth
    let myColors = MyColors()
    
    var cards:[OnBoardCard] = OnBoardCardModel().cards
    
    var body: some View {
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack{
                    TabView(selection: $selectedPage){
                        ForEach(0..<cards.count){
                            index in
                            if(index != (cards.count - 1)){
                                
                                VStack{
                                    Spacer()
                                    Image(systemName: cards[index].image)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 180))
                                        .foregroundColor(myColors.greenColor)
                                    Spacer()
                                    Text(cards[index].title)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 26))
                                        .foregroundColor(.white)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .padding()
                                    Text(cards[index].description)
                                        .multilineTextAlignment(.center)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                        .foregroundColor(.white)
                                        .padding()
                                    Spacer()
                                }.tag(index)
                            }
                            else{
                                VStack{
                                    Spacer()
                                    Image(systemName: cards[index].image)
                                        .font(.system(size: 180))
                                        .foregroundColor(myColors.greenColor)
                                    Spacer()
                                    Text(cards[index].title)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 26))
                                        .foregroundColor(.white)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .padding()
                                    Text(cards[index].description)
                                        .multilineTextAlignment(.center)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                        .foregroundColor(.white)
                                        .padding()
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                            
                                                userAuth.user.isOnBoarded = true
                                                API().OnBoardCompleted()
                                                
                                            }, label: {
                                                Text("Continue")
                                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                                    .foregroundColor(myColors.greenColor)
                                                    .bold()
                                                    .padding()
                                                    .shadow(color: Color.green, radius: 6, x: 2, y: 2)
                                            })
                                        }.padding(.trailing, 20)
                                    })
                                    Spacer()
                                }.tag(index)
                                
                            }
                            
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                    
                }
            )
    }
}


struct OnBoardPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardPageView().environmentObject(UserAuth())
    }
}
