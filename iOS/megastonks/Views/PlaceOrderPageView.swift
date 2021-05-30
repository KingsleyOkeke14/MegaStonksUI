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
    @State var showTip:Bool = false
    @State var ownedShares:Double = 0.0
    
    @State var errorMessage:String = ""
    
    @State var showOrderSuccessPage:Bool = false
    @State var isLoading:Bool = false
    
    @State var orderResult:OrderResultInfo?
    
    
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
                            .font(.custom("Verdana", fixedSize: 20))
                    }.padding(.top, 20)
                    VStack{
                        Text("How many shares of \"\(stockSymbol.symbol)\"")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 24))
                            .multilineTextAlignment(.center)
                        Text("do you want to \(orderAction.uppercased())?")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 24))
                            .multilineTextAlignment(.center)
                    }.padding()
                    HStack{
                        Text(String(quantityEntry.joined(separator: "")))
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 50))
                            .padding()
                        
                    }.frame(height: 40)
                    Spacer()
                    VStack(spacing: 2){
                        if(!errorMessage.isEmpty){
                            HStack{
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            }
                        }
        
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
                                    .shadow(color: Double(String(quantityEntry.joined(separator: ""))) ?? 0.0  > ownedShares ? .red : .white, radius: 12, x: 2, y: 4)
                                    .foregroundColor(Double(String(quantityEntry.joined(separator: ""))) ?? 0.0  > ownedShares ? .red : .white)
                                    .onChange(of: quantityEntry, perform: { newValue in
                                        estimatedCost = (stockSymbol.price  * (Double(String(newValue.joined(separator: ""))) ?? 0.0))
                                        
                                    })
                            }
                            
                        }
                        HStack{
                            if (orderAction.uppercased() == "BUY"){
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
                            else if(orderAction.uppercased() == "SELL"){
                                Text("Available Shares")
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(ownedShares.formatNoDecimal())")
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    .foregroundColor(.white)
                                
                            }
                        }
                        NumberPadView(codes: $quantityEntry).onTapGesture {
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                        }
                        Button(action: {
                            isLoading = true
                            let quantityToSend = Int(String(quantityEntry.joined(separator: ""))) ?? 0
                            myAppObjects.orderStock(stockId: stockSymbol.stockId, orderType: "MarketOrder", orderAction: orderAction, quantitySubmitted: quantityToSend){
                                result in
                                
                                if (result.isSuccessful){
                                    orderResult = result.orderStockResponse
                                    isLoading = false
                                    showOrderSuccessPage = true
                                    myAppObjects.getStockHoldingsAsync()
                                }
                                else{
                                    errorMessage = result.errorMessage
                                    isLoading = false
                                }
                                
                            }
                            
                            
                        }, label: {
                            Text("SEND ORDER")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(.green)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(myColors.grayColor)
                                .cornerRadius(12)
                            
                        })
                        HStack{
                            Button(action: {
                                showTip.toggle()
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.white)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                            })
                            if(showTip){
                                Text("Please note that your order might not fill at the price shown above. Your order will be filled at the market price at the time of execution")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                
                            }, label: {
                                Text("Cancel")
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    .foregroundColor(myColors.greenColor)
                            })
                        }.padding(.horizontal)
                        
                        
                    }
                    
                    .padding(.horizontal)
                }.lineLimit(1).padding(.horizontal)
                .overlay(
                            VStack{
                                if(isLoading){
                                    Color.black
                                        .overlay(
                                            ProgressView()
                                                .accentColor(.green)
                                                .scaleEffect(x: 1.4, y: 1.4)
                                                .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                        )

                                }
                                else if(!isLoading && showOrderSuccessPage){
                                    OrderSucessPageView(orderResult: orderResult!)                .onDisappear(perform: {
                                        myAppObjects.updateStockWatchList(){
                                            result in
                                            if(result.isSuccessful){
                                                DispatchQueue.main.async {
                                                    NotificationCenter.default.post(name: .didWalletChange, object: nil)
                                                    print("Profile Page Should be Updated")
                                                }
                                                print("Refreshed WatchList After Placing Order")
                                            }
                                        }
                                    })
                                }
                            }
                    
                )
                .minimumScaleFactor(0.4)
                .onAppear(perform: {
                    myAppObjects.getWalletAsync()
                    myAppObjects.getStockHoldings(){
                        result in
                        if(result.isSuccessful){
                            DispatchQueue.main.async {
                                myAppObjects.holdings = result.stockHoldingsResponse!
                            }
                            if(orderAction.uppercased() == "SELL"){
                                let filtered = myAppObjects.holdings.holdings.filter {$0.stockId == stockSymbol.stockId}
                                if(!filtered.isEmpty){
                                    ownedShares = filtered[0].quantity
                                }
                                
                            }
                        }
                    }
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
