//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct AssetWatchListPage: View {
    
    
    let myColors = MyColors()
    var isCrypto: Bool
    
    @State var searchText:String = ""
    
    @State private var selectedItem: String?
    
    @State var isEditing: Bool = false
    
    @State var isLoadingAsset: Bool = false
    @State var isLoadingWatchlist: Bool = false
    
    @State var isMarketOpen:Bool?
    @State var didAppear = false
    @State var shouldRefreshWatchlist = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var myAppObjects:AppObjects
    
    let stockRefreshtimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    let cryptoRefreshtimer = Timer.publish(every: 600, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if(!isCrypto){
                VStack{
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
                            Text("The US Stock Market is Open")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                .offset(x: 0, y: 2)
                        }
                        else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.red)
                                .shadow(color: Color.red, radius: 6, x: -0.8, y: 1)
                            Text("The US Stock Market is Closed")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                .offset(x: 0, y: 2)
                        }
                    }
                    .onAppear(perform: {
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
                        TextField("Tap to Search for Stocks", text: $searchText, onCommit: {
                            isLoadingAsset = true
                            myAppObjects.searchStock(stockToSearch: searchText){
                                result in
                                if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        myAppObjects.stockSearchResult = result.stockSearchResponse
                                    }
                                }
                                isLoadingAsset = false
                               
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
                                isLoadingAsset = false
                                hideKeyboard()
                                presentationMode.wrappedValue.dismiss()
                                myAppObjects.stockSearchResult.removeAll()
                                myAppObjects.searchStockAsync()
                                
                            }) {
                                Text("Cancel")
                                    .foregroundColor(myColors.greenColor)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }
                    .padding(.horizontal).padding(.vertical, 2)
                    
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
                                                destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: stock.stockId, stock: nil)
                                                    .onDisappear(perform: {
                                                        myAppObjects.updateStockWatchListAsync()
                                                        myAppObjects.getStockHoldingsAsync()
                                                    }),
                                                tag: stock.id.uuidString,
                                                selection: $selectedItem,
                                                label: {StockSearchView(stock: stock)})
                                        }
                                    }.padding(.horizontal)
                                    
                                }.overlay(
                                    VStack{
                                        if(isLoadingAsset){
                                        Color.black
                                            .ignoresSafeArea()
                                            .overlay(
                                                ProgressView()
                                                    .accentColor(.green)
                                                    .scaleEffect(x: 1.4, y: 1.4)
                                                    .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                            )
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
                                    .overlay(
                                        VStack{
                                            if(isLoadingAsset){
                                            Color.black
                                                .ignoresSafeArea()
                                                .overlay(
                                                    ProgressView()
                                                        .accentColor(.green)
                                                        .scaleEffect(x: 1.4, y: 1.4)
                                                        .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                                
                                                )
                                            }
                                        })
                            }
                            
                            Spacer()
                        }
                    }
                    if(!isEditing){
                    HStack{
                        Text("Stock Watchlist")
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
                            if(!myAppObjects.stockWatchList.isEmpty){
                                ScrollView{
                                    VStack(spacing: 0) {
                                        PullToRefreshView(onRefresh:{
                                            isLoadingWatchlist = true
                                            myAppObjects.updateStockWatchList(){
                                                result in
                                                if(result.isSuccessful){
                                                    isLoadingWatchlist = false
                                                }
                                                else{
                                                    //Would need to show error message here or something
                                                    isLoadingWatchlist = false
                                                }
                                                shouldRefreshWatchlist = false
                                            }
                                        })
                                    }
                                    LazyVStack {
                                        ForEach(myAppObjects.stockWatchList, id: \.self){ stock in
                                            NavigationLink(
                                                destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: 0, stock: stock).environmentObject(myAppObjects).onDisappear(perform: {
                                                    myAppObjects.updateStockWatchListAsync()
                                                    myAppObjects.getStockHoldingsAsync()
                                                }),
                                                tag: stock.id.uuidString,
                                                selection: $selectedItem,
                                                label: {StockSymbolView(stock: stock)})
                                            
                                        }
                                    }.padding(.horizontal)
                                }
                                
                            }
                            else if(myAppObjects.stockWatchList.isEmpty && !isLoadingWatchlist){
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
                    }
                .onAppear(perform: {
                    onLoad()
                })
                .onReceive(self.stockRefreshtimer, perform: { _ in
                    shouldRefreshWatchlist = true
                })
                .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        }
        else {
            VStack{
                VStack{
                    HStack{
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.green)
                            .shadow(color: Color.green, radius: 6, x: -0.8, y: 1)
                        Text("The Crypto Market Trades 24/7")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                            .offset(x: 0, y: 2)
                    }
                    HStack {
                        TextField("Tap to Search For Crypto", text: $searchText, onCommit: {
                            isLoadingAsset = true
                            myAppObjects.searchCrypto(cryptoToSearch: searchText){
                                result in
                                if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        myAppObjects.cryptoSearchResult = result.cryptoSearchResponse
                                    }
                                }
                                isLoadingAsset = false
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
                                isLoadingAsset = false
                                hideKeyboard()
                                presentationMode.wrappedValue.dismiss()
                                myAppObjects.cryptoSearchResult.removeAll()
                                myAppObjects.populateCryptoListAsync()
                                
                            }) {
                                Text("Cancel")
                                    .foregroundColor(myColors.greenColor)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }
                    
                    .padding(.horizontal).padding(.vertical, 2)
                    
                    if(isEditing){
                        VStack{
                            HStack{
                                Text("Crypto Currencies")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                    .fontWeight(.heavy)
                                    .bold()
                                    .foregroundColor(myColors.greenColor)
                                Spacer()
                                
                            }
                            .padding(.horizontal)
                            
                            if(!myAppObjects.cryptoSearchResult.isEmpty){
                                
                                ScrollView{
                                    LazyVStack{
                                        ForEach(myAppObjects.cryptoSearchResult, id: \.self){ crypto in
                                            NavigationLink(
                                                destination: CryptoInfoPageView(cryptoToSearch: crypto.cryptoId, crypto: nil, cryptoQuote: nil)
                                                    .onDisappear(perform: {
                                                        myAppObjects.updateCryptoWatchListAsync()
                                                        myAppObjects.getStockHoldingsAsync()
                                                    }),
                                                tag: crypto.id.uuidString,
                                                selection: $selectedItem,
                                                label: {CryptoSearchView(crypto: crypto)})
                                        }
                                    }.padding(.horizontal)
                                    
                                }.overlay(
                                    VStack{
                                        if(isLoadingAsset){
                                        Color.black
                                            .ignoresSafeArea()
                                            .overlay(
                                                ProgressView()
                                                    .accentColor(.green)
                                                    .scaleEffect(x: 1.4, y: 1.4)
                                                    .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                            
                                            )
                                        }
                                    })
                            }
                            else{
                                Spacer()
                                Text("Could not find what you were looking for? Please remember that we only provide access to select stable crypto currencies at this time. Please contact us if you have any further questions")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .overlay(
                                        VStack{
                                            if(isLoadingAsset){
                                            Color.black
                                                .ignoresSafeArea()
                                                .overlay(
                                                    ProgressView()
                                                        .accentColor(.green)
                                                        .scaleEffect(x: 1.4, y: 1.4)
                                                        .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                                
                                                )
                                            }
                                        })
                            }
                            Spacer()
                        }
                    }
                    if(!isEditing){
                        HStack{
                            Text("Crypto Watchlist")
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
                            if(!myAppObjects.cryptoWatchList.isEmpty){
                                ScrollView{
                                    VStack(spacing: 0) {
                                        PullToRefreshView(onRefresh:{
                                            isLoadingWatchlist = true
                                            myAppObjects.updateCryptoWatchList(){
                                                result in
                                                if(result.isSuccessful){
                                                    isLoadingWatchlist = false
                                                }
                                                else{
                                                    //Would need to show error message here or something
                                                    isLoadingWatchlist = false
                                                }
                                                shouldRefreshWatchlist = false
                                            }
                                        })
                                        LazyVStack {
                                            ForEach(myAppObjects.cryptoWatchList, id: \.self){ crypto in
                                                NavigationLink(
                                                    destination: CryptoInfoPageView(cryptoToSearch: 0, crypto: crypto, cryptoQuote: userAuth.user.currency == "USD" ? CryptoQuote(crypto.usdQuote) : CryptoQuote(crypto.cadQuote)).environmentObject(myAppObjects).onDisappear(perform: {
                                                        myAppObjects.updateCryptoWatchListAsync()
                                                        //myAppObjects.getStockHoldingsAsync()
                                                    }),
                                                    tag: crypto.crypto.id.uuidString,
                                                    selection: $selectedItem,
                                                    label: {CryptoSymbolView(cryptoSymbol: crypto, cryptoQuote: userAuth.user.currency == "USD" ? CryptoQuote(crypto.usdQuote) : CryptoQuote(crypto.cadQuote))})
                                            }
                                        }.padding(.horizontal)
                                    }
                                }
                                
                            }
                            else if(myAppObjects.cryptoWatchList.isEmpty && !isLoadingWatchlist){
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
                                    Text("Surely, there are some assets you would like to track in your crypto watchlist")
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
                }.onAppear(perform: {
                    myAppObjects.getStockHoldingsAsync()
                    if(shouldRefreshWatchlist){
                        isLoadingWatchlist = true
                        myAppObjects.updateCryptoWatchList(){
                            result in
                            if(result.isSuccessful){
                                isLoadingWatchlist = false
                            }
                            else{
                                //Would need to show error message here or something
                                isLoadingWatchlist = false
                            }
                            shouldRefreshWatchlist = false
                        }
                    }
                })
                
            }
            .onAppear(perform: {
                onLoad()
            })
            .onReceive(self.cryptoRefreshtimer, perform: { _ in
                shouldRefreshWatchlist = true
            })
            .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        }
        
    }
    
    func onLoad() {
        if !didAppear || shouldRefreshWatchlist{
            reloadData()
            didAppear = true
            shouldRefreshWatchlist = false
        }
    }
    
    func reloadData(){
        isLoadingWatchlist = true
        if(isCrypto){
            myAppObjects.getStockHoldingsAsync()
            myAppObjects.updateCryptoWatchList(){
                result in
                if(result.isSuccessful){
                    isLoadingWatchlist = false
                }
                else{
                    //Would need to show error message here or something
                    isLoadingWatchlist = false
                }
            }
        }
        else{
            myAppObjects.getStockHoldingsAsync()
            myAppObjects.updateStockWatchList(){
                result in
                if(result.isSuccessful){
                    isLoadingWatchlist = false
                }
                else{
                    //Would need to show error message here or something
                    isLoadingWatchlist = false
                }
            }
        }

    }
}
    
    struct StocksWatchListPageView_Previews: PreviewProvider {
        static var previews: some View {
            AssetWatchListPage(isCrypto: false)
                .environmentObject(AppObjects())
                .preferredColorScheme(.dark)
        }
    }
