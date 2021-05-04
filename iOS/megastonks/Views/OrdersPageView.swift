//
//  OrdersPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import SwiftUI

struct OrdersPageView: View {
    
    @EnvironmentObject var myAppObjects:AppObjects
    
    let myColors = MyColors()
    var body: some View {
        VStack{
            VStack(spacing: 0) {
                
                HStack {
                    Text("Orders")
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
            if(!myAppObjects.orderHistory.history.isEmpty){
                ScrollView{
                    LazyVStack {
                        ForEach(myAppObjects.orderHistory.history, id: \.self){ order in
                            OrderView(orderHistoryElement: order)
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
        OrdersPageView().environmentObject(AppObjects()).preferredColorScheme(.dark)
    }
}
