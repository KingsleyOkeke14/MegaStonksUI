//
//  ProfilePageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct ProfilePageView: View {
    let myColors = MyColors()
    
    
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var myAppObjects:AppObjects
    
    @State var userWallet:UserWallet = UserWallet(WalletResponse(firstName: "", lastName: "", cash: 0.0, initialDeposit: 0.0, investments: 0.0, total: 0.0, percentReturnToday: 0.0, moneyReturnToday: 0.0, percentReturnTotal: 0.0, moneyReturnTotal: 0.0))
    @State var isLoading:Bool = true
    
    
    let pub = NotificationCenter.default.publisher(for: .didWalletChange)
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .systemGray4
    }
    
    var body: some View {
        NavigationView{
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(spacing: 12){
                        
                        HStack{
                            Text("Account")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .padding(.horizontal)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            NavigationLink(
                                destination: ProfileSettingsPageView().environmentObject(userAuth)){
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 24))
                                    .foregroundColor(Color.green)
                            }.padding(.horizontal)
                        }
                        
                        
                        HStack{
                            Text("$ \(userWallet.total.formatPrice())")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Verdana", fixedSize: 24))
                                .bold()
                                +
                                Text(" \(userAuth.user.currency)")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Verdana", fixedSize: 12))
                                .bold()
                                .baselineOffset(-0.4)
                            
                        }.lineLimit(1).minimumScaleFactor(0.5)
                        
                        UserProfileWalletSummary(firsName: $userWallet.firstName, lastName: $userWallet.lastName, cash: $userWallet.cash, investments: $userWallet.investments, initialDeposit: $userWallet.initialDeposit, cashPercentage: $userWallet.cashPercentage)
                        
                        
                        
                        NavigationLink(
                            destination: OrdersPageView().environmentObject(myAppObjects),
                            label: {
                                VStack(spacing: 0) {
                                    
                                    HStack {
                                        Text("Orders")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                            .bold()
                                            .foregroundColor(myColors.greenColor)
                                        
                                        Spacer()
                                        Image(systemName: "chevron.forward.circle")
                                            .foregroundColor(myColors.greenColor)
                                        
                                    }
                                    Rectangle()
                                        .fill(myColors.greenColor)
                                        .frame(height: 2)
                                        .edgesIgnoringSafeArea(.horizontal)
                                    
                                }.padding(.horizontal)
                            })
                            
                        
                        
                        if(!myAppObjects.orderHistory.history.isEmpty){
                            OrderView(orderHistoryElement: myAppObjects.orderHistory.history[0]).padding(.top, 10)
                        }
                      
                        Spacer()
                        AdsView()
                        HStack{
                            
                        }.frame(height: 2, alignment: .center)
                        
                    
                    }.onAppear(perform: {
                        isLoading = true
                        myAppObjects.getOrderHistoryAsync()
                        myAppObjects.getWallet(){
                            result in
                            if(result.isSuccessful){
                                //I should change the environment object here. However, this prevents the vieew from refreshing so I am only going to update the view state
                                DispatchQueue.main.async {
                                     
                                    myAppObjects.userWallet = result.walletResponse!
                                    userWallet = myAppObjects.userWallet
                                    isLoading = false
                                    print("Wallet Refreshed")
                                }
                               
                            }
                        }
                        isLoading = false
                    })
                    
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        
        
        }
        .onReceive(pub, perform: { _ in
            myAppObjects.getOrderHistoryAsync()
            myAppObjects.getWallet(){
                result in
                if(result.isSuccessful){
                    //I should change the environment object here. However, this prevents the vieew from refreshing so I am only going to update the view state
                    DispatchQueue.main.async {
                        myAppObjects.userWallet = result.walletResponse!
                        userWallet = myAppObjects.userWallet
                        isLoading = false
                        print("Wallet Refreshed")
                    }
                }
            }
        })
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
            }
        )

        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RadialWalletView: View {
    @Binding var percentage:Double
    
    var body: some View {
        ZStack{
            Image("megastonkslogo")
                .scaleEffect(0.3)
                .aspectRatio(contentMode: .fit)
            RadialChartView(percentage: CGFloat(percentage), width: 100, height: 100, lineWidth: 6, lineCapStyle: CGLineCap.square)
        }.padding(.horizontal, -20)
    }
}



struct UserProfileWalletSummary: View {
    
    @Binding var firsName:String
    @Binding var lastName:String
    @Binding var cash:Double
    @Binding var investments:Double
    @Binding var initialDeposit:Double
    @Binding var cashPercentage:Double
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                RadialWalletView(percentage: $cashPercentage)
            }
            VStack(alignment: .leading){
                Text(firsName.uppercased())
                    .font(.custom("Marker Felt", fixedSize: 20))
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)                    
                
                Text(lastName.uppercased())
                    .font(.custom("Marker Felt", fixedSize: 20))
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                HStack{
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("CASH:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$\(cash.formatPrice())")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
                HStack{
                    Circle()
                        .opacity(0.3)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("INVESTMENTS:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$\(investments.formatPrice())")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
                HStack{
                    Circle()//This is not visible. Just there to ensure the same space with Investments Text
                        .opacity(0)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("Initial Deposit:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$\(initialDeposit.formatPrice())")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
            }.padding(.trailing)
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView().environmentObject(UserAuth())
            .environmentObject(AppObjects())
    }
}

