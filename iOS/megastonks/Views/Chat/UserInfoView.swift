//
//  UserInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-27.
//

import SwiftUI

struct UserInfoView: View {
    var body: some View {
                VStack {
                    ZStack {
                        Circle()
                            .stroke(myColors.greenColor, lineWidth: 4)
                            .frame(width: 100, height: 100)
                        
                        Circle()
                            .fill(Color.green.opacity(0.1))
                            .frame(width: 100, height: 100)
                        
                        Text("🤩")
                            .font(.custom("", fixedSize: 70))
                            .offset(y: 3)
                        
                    }
                    
                    Text("@KenzoDrizzy")
                        .font(.custom("Helvetica", fixedSize: 18))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Text("Please remember that your chat credentials are unique to you and your device. This allows us to maintain your anonymity. If you end this chat session, you will have to select another username")
                        .font(.custom("Helvetica", fixedSize: 14))
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 10)
                        

                    
                }
//                .padding(.top)
//                .padding(.horizontal, -16)
//                .background(Color.black.opacity(0.8))
//                .cornerRadius(20)

    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView().preferredColorScheme(.dark)
    }
}
