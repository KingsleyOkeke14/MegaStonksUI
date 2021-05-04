//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct WatchListPageView: View {
    
    
    let myColors = MyColors()
    @State var searchText:String = ""
    
    @State private var selectedItem: String?
    
    @State var isEditing: Bool = false
    
    @State var isLoadingStock: Bool = false
    @State var isLoadingWatchlist: Bool = false
    
    @State var isMarketOpen:Bool?
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var myAppObjects:AppObjects
    
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
        
        let color = UIView()
        color.backgroundColor = .systemGray6
        UITableViewCell.appearance().selectedBackgroundView = color
    }
        
    var body: some View {
        NavigationView{
            VStack{
                Image("megastonkslogo")
                    .scaleEffect(0.6)
                    .aspectRatio(contentMode: .fit)
                HStack{
                    if(isMarketOpen == nil){
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.gray)
                            .shadow(color: Color.gray, radius: 4, x: -0.8, y: -1)
                        Text("Could Not Get Market Status")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            .offset(x: 0, y: 2)
                    }
                    else if(isMarketOpen!){
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.green)
                            .shadow(color: Color.green, radius: 6, x: -0.8, y: 1)
                        Text("Market is Open")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            .offset(x: 0, y: 2)
                    }
                    else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.red)
                            .shadow(color: Color.red, radius: 6, x: -0.8, y: 1)
                        Text("Market is Closed")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            .offset(x: 0, y: 2)
                    }

                }.onAppear(perform: {
                    API().IsMarketOpen(){
                        result in
                        if(result.isSuccessful){
                            if let data = result.data, let jsonString = String(data: data, encoding: .utf8) {
                                isMarketOpen = jsonString.toBool
                            }
                        }
                    }
                })
                HStack {
                    TextField("Tap to Start Search", text: $searchText, onCommit: {
                        isLoadingStock = true
                        myAppObjects.searchStock(stockToSearch: searchText){
                            result in
                            if(result.isSuccessful){
                                
                                DispatchQueue.main.async {
                                    myAppObjects.stockSearchResult = result.stockSearchResponse
                                }
                            }
                            isLoadingStock = false
                        }
                        
                    })
                    .padding()
                    .padding(.horizontal, 24)
                    .background(myColors.grayColor)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .cornerRadius(20)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(myColors.lightGrayColor)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 12)
                        }
                        
                    )
                    .onTapGesture {
                        self.isEditing = true
                    }
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.searchText = ""
                            isLoadingStock = false
                            hideKeyboard()
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Text("Cancel")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }.padding(.horizontal).padding(.vertical, 2)
                
                if(isEditing){
                    VStack{
                        HStack{
                            Text("Stocks")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        
                        if(!myAppObjects.stockSearchResult.isEmpty){
                            
                                ScrollView{
                                    LazyVStack{
                                    ForEach(myAppObjects.stockSearchResult, id: \.self){ stock in
                                        NavigationLink(
                                            destination: StocksInfoPageView2(stockToGet: stock, showOrderButtons: true, showWatchListButton: true)
                                                .onDisappear(perform: {
                                                myAppObjects.updateWatchListAsync()
                                                myAppObjects.getStockHoldingsAsync()
                                            }),
                                            tag: stock.id.uuidString,
                                            selection: $selectedItem,
                                            label: {StockSearchView(stock: stock)})
                                    }
                                    }.padding(.horizontal)
                                
                            }.overlay(
                                VStack{
                                    if(isLoadingStock){
                                        ProgressView()
                                            .accentColor(.green)
                                            .scaleEffect(x: 1.4, y: 1.4)
                                            .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                    }
                                })
                        }
                        else{
                            Spacer()
                            Text("Could not find what you were looking for? Please remember that we only provide access to the US and Canadian stock market at this time. Please contact us if you have any further questions")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                    }.frame(height: 300)
                }
                HStack{
                    Text("Watchlist")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(myColors.greenColor)
                    Image(systemName: "eye")
                        .foregroundColor(myColors.greenColor)
                        .font(.custom("", fixedSize: 18))
                    Spacer()
                    
                }
                .padding(.horizontal)
                VStack{
                    if(!myAppObjects.watchList.isEmpty){
                        ScrollView{
                            LazyVStack {
                                ForEach(myAppObjects.watchList, id: \.self){ stock in
                                    NavigationLink(
                                        destination: StocksInfoPageView(stock: stock).environmentObject(myAppObjects).onDisappear(perform: {
                                            myAppObjects.updateWatchListAsync()
                                            myAppObjects.getStockHoldingsAsync()
                                        }),
                                        tag: stock.id.uuidString,
                                        selection: $selectedItem,
                                        label: {StockSymbolView(stock: stock)})

                                }
                            }.padding(.horizontal)
                        }

                    }
                    else if(myAppObjects.watchList.isEmpty && !isLoadingWatchlist){
                        Spacer()
                        VStack(spacing: 16){
                                Text("Wow! Such Empty!")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                    .bold()
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                Text("😒")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                Text("Surely, there are some assets you would like to track in your watchlist")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                    .bold()
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                            }
                    }
                    Spacer()
                }.overlay(
                        VStack{
                            if(isLoadingWatchlist){
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }.onAppear(perform: {
            isLoadingWatchlist = true
            myAppObjects.getStockHoldingsAsync()
            myAppObjects.updateWatchList(){
                result in
                if(result.isSuccessful){
                    isLoadingWatchlist = false
                }
                else{
                    //Would need to show error message here or something
                    isLoadingWatchlist = false
                }
            }
           
        })
        .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListPageView()
            .environmentObject(AppObjects())
            .preferredColorScheme(.dark)
    }
}
