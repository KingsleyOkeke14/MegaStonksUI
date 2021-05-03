//
//  BannerViewModifier.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import SwiftUI

struct BannerData {
    var title:String
    var detail:String
    var type: BannerType
}

enum BannerType {
    case Info
    case Warning
    case Success
    case Error
    
    var tintColor: Color {
        switch self {
        case .Info:
            return MyColors().lightGrayColor
        case .Success:
            return MyColors().greenColor
        case .Warning:
            return MyColors().darkYellowColor
        case .Error:
            return Color.red
        }
    }
}



struct BannerViewModifier: ViewModifier {
    
    @Binding var data:BannerData
    @Binding var show:Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if(show && !data.detail.isEmpty ){
                VStack {
                    HStack(alignment: .center){
                        // Banner Content Here
                        VStack(alignment: .center, spacing: 2) {
                            if(!data.title.isEmpty){
                                Text(data.title)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                    .bold()
                            }
                            Text(data.detail)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                        }.foregroundColor(Color.white)
                    }.foregroundColor(Color.white)
                    .padding(8)
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
//                    .onTapGesture {
//                        withAnimation {
//                            self.show = true
//                        }
//                    }
                    .gesture(
                        DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                    .onEnded { value in
                                        let horizontalAmount = value.translation.width as CGFloat
                                        let verticalAmount = value.translation.height as CGFloat
                                        
                                        if abs(horizontalAmount) > abs(verticalAmount) {
                                            print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                        } else {
                                            withAnimation {
                                                self.show = false
                                            }
                                            print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                        }
                                    }
                    
                    
                    )
                    .background(data.type.tintColor)
                    .cornerRadius(20)
                    Spacer()
                        
                            
                        }.onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.show = false
                                }
                            }
                        })
                }
            }
        }
        
    }
    
    extension View {
        func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
            self.modifier(BannerViewModifier(data: data, show: show))
        }
    }
    
    
    
    
    struct TestView: View {
        
        @State var bannerData:BannerData = BannerData(title: "Order Status", detail: "Your Order has been Processed", type: .Error)
        @State var showBanner:Bool = true
        
        var body: some View {
            VStack{
                Image(systemName: "figure.wave")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 180))
                    .foregroundColor(MyColors().greenColor)
                
                Text("This is the App")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                    .foregroundColor(.red)
                    .bold()
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                
                
                Text("Congratulations")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
            }.banner(data: $bannerData, show: $showBanner)
            
        }
        
        
    }
    
    
    struct BannerViewModifier_Previews: PreviewProvider {
        static var previews: some View {
            TestView()
        }
    }
