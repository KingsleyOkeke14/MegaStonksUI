//
//  CompanyInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct CompanyInfoView: View {
    let myColors = MyColors()
    var body: some View {
            
            
            
        VStack(alignment: .leading, spacing: 2){
            Text("Company Information")
                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                .bold()
                .foregroundColor(myColors.greenColor)
                .padding(.top)
            
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
            Text("CloudMD is part of CloudMD Software & Services Inc.. The company offers SAAS based health technology solutions to medical clinics across Canada and has developed proprietary technology to deliver quality healthcare through the combination of connected primary care clinics, telemedicine, and artificial intelligence (AI).")
                .foregroundColor(.white)
                .font(.custom("Verdana", fixedSize: 18))
            
        }.padding()
            
    }
}

struct CompanyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyInfoView()
    }
}
