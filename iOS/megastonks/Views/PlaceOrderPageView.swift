//
//  PlaceOrderView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-01.
//

import SwiftUI

struct PlaceOrderPageView: View {
    @State var quantityEntry:[String] = [""]
    @State var estimatedCost:Double = 0.0
    @Binding var stockSymbol:StockSymbol
    @Binding var orderAction:String
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
    let myColors = MyColors()
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    HStack{
                        Text("\(orderAction.uppercased()) Order")
                            .foregroundColor(myColors.greenColor)
                            .font(.custom("Verdana", fixedSize: 26))
                    }.padding(.top, 20)
                    VStack{
                        Text("How many shares of \"\(stockSymbol.symbol)\"")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 30))
                            .multilineTextAlignment(.center)
                        Text("do you want to \(orderAction.uppercased())?")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 30))
                            .multilineTextAlignment(.center)
                    }.padding()
                    HStack{
                        Text(String(quantityEntry.joined(separator: "")))
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 50))
                            .padding()
                           
                    }
                    Spacer()
                    VStack(spacing: 8){
                            HStack{
                               Text("Order Type")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(myColors.greenColor)
                                Spacer()
                                Text("Market \(orderAction)")
                                 .bold()
                                 .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                 .foregroundColor(myColors.greenColor)
                            }
                            HStack{
                               Text("Price Per Share")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(.white)
                                Spacer()
                                Text("$\(stockSymbol.price.formatPrice()) \(stockSymbol.currency)")
                                 .bold()
                                 .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    .foregroundColor(.white)
                            }
                            HStack{
                                if(orderAction.uppercased() == "BUY"){
                                    Text("Estimated Cost")
                                     .bold()
                                     .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                     .foregroundColor(.white)
                                     Spacer()
                                     Text("$\(estimatedCost.formatPrice()) \(stockSymbol.currency)")
                                      .bold()
                                      .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                      .shadow(color: estimatedCost > myAppObjects.userWallet.cash ? .red : .white, radius: 12, x: 2, y: 4)
                                         .foregroundColor(estimatedCost > myAppObjects.userWallet.cash ? .red : .white)
                                         .onChange(of: quantityEntry, perform: { newValue in
                                             estimatedCost = (stockSymbol.price  * (Double(String(newValue.joined(separator: ""))) ?? 0.0))
                                         })
                                }
                                else if (orderAction.uppercased() == "SELL"){
                                    Text("Estimated Value")
                                     .bold()
                                     .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                     .foregroundColor(.white)
                                     Spacer()
                                     Text("$\(estimatedCost.formatPrice()) \(stockSymbol.currency)")
                                      .bold()
                                      .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                        .shadow(color: Double(String(quantityEntry.joined(separator: ""))) ?? 0.0 > myAppObjects.userWallet.cash ? .red : .white, radius: 12, x: 2, y: 4)
                                         .foregroundColor(estimatedCost > myAppObjects.userWallet.cash ? .red : .white)
                                         .onChange(of: quantityEntry, perform: { newValue in
                                             estimatedCost = (stockSymbol.price  * (Double(String(newValue.joined(separator: ""))) ?? 0.0))
                                         })
                                }

                            }
                            HStack{
                               Text("Available Balance")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(.white)
                                Spacer()
                                Text("$\(myAppObjects.userWallet.cash.formatPrice()) \(userAuth.user.currency)")
                                 .bold()
                                 .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    .foregroundColor(.white)
                            }
                            NumberPadView(codes: $quantityEntry).onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            }

                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }, label: {
                            Text("Cancel")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(myColors.greenColor)
                        })
                        
                        
                        }
             
                    .padding(.horizontal)
                }.lineLimit(1)
                .onTapGesture {
                }
                .minimumScaleFactor(0.4)
                .onAppear(perform: {
                    myAppObjects.getWallet()
                })
            )
        
    }
}

struct PlaceOrderPageView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrderPageView(stockSymbol: Binding.constant(StockSymbolModel().symbols[0]), orderAction: Binding.constant("Buy"))
            .environmentObject(AppObjects())
            .environmentObject(UserAuth())
    }
}
