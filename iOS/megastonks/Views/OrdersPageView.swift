//
//  OrdersPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import SwiftUI

struct OrdersPageView: View {
    
    var isCrypto: Bool
    @EnvironmentObject var myAppObjects:AppObjects
    
    let myColors = MyColors()
    var body: some View {
        VStack{
            VStack(spacing: 0) {
                
                HStack {
                    Text(isCrypto ? "Crypto Orders" : "Stock Orders")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                        .bold()
                        .foregroundColor(myColors.greenColor)
                    
                    Spacer()
                }
                Rectangle()
                    .fill(myColors.greenColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }.padding(.horizontal).padding()
            
            
            if(!myAppObjects.orderStockHistory.history.isEmpty && !isCrypto){
                ScrollView{
                    LazyVStack {
                        ForEach(myAppObjects.orderStockHistory.history, id: \.self){ order in
                            OrderStockHistoryView(orderHistoryElement: order)
                        }
                    }.padding(.horizontal)
                }
            }
            
            if(!myAppObjects.orderCryptoHistory.history.isEmpty && isCrypto){
                ScrollView{
                    LazyVStack {
                        ForEach(myAppObjects.orderCryptoHistory.history, id: \.self){ order in
                            OrderCryptoHistoryView(orderHistoryElement: order)
                        }
                    }.padding(.horizontal)
                }
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OrdersPageView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersPageView(isCrypto: false).environmentObject(AppObjects()).preferredColorScheme(.dark)
    }
}
