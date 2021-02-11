//
//  RadialChartView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct RadialChartView: View {
    var percentage: CGFloat
    var width:CGFloat
    var height:CGFloat
    var lineWidth:CGFloat
    var lineCapStyle:CGLineCap
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(Color.green)
            
            Circle()
                .trim(from: 0.0, to: percentage)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCapStyle, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear)
        }.frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct RadialChartView_Previews: PreviewProvider {
    static var previews: some View {
        RadialChartView(percentage: 0.3, width: 60, height: 60, lineWidth: 4, lineCapStyle: CGLineCap.round)
    }
}
