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
    @State var didAppear = false //This is used to verify that some actions only happen once when the view is loaded in the apps current lifecycle because onappear is called multiple times in swiftui
    @State var shouldRefreshWatchlist = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var stockWatchListVM: StockWatchListVM
    @EnvironmentObject var cryptoWatchListVM: CryptoWatchListVM
    @EnvironmentObject var stockHoldingsVM: StockHoldingsVM
    @EnvironmentObject var cryptoHoldingsVM: CryptoHoldingsVM
    @EnvironmentObject var stockSearchResultVM: StockSearchResultVM
    @EnvironmentObject var cryptoSearchResultVM: CryptoSearchResultVM
    @EnvironmentObject var stockOrderVM: StockOrderVM
    @EnvironmentObject var cryptoOrderVM: CryptoOrderVM
    @EnvironmentObject var userWalletVM: UserWalletVM
    
    //let stockRefreshtimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    let cryptoRefreshtimer = Timer.publish(every: 600, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if(!isCrypto){
            VStack{
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
                        TextField("Tap to Search for Stocks", text: $searchText) { isEditing in
                            if(isEditing){
                                self.isEditing = isEditing
                            }
                        } onCommit: {
                            isLoadingAsset = true
                            stockSearchResultVM.searchStock(stockToSearch: searchText){
                                result in
                                if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        stockSearchResultVM.stockSearchResult = result.stockSearchResponse
                                    }
                                }
                                isLoadingAsset = false
                                
                            }
                        }
                        .disableAutocorrection(true)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(myColors.grayColor)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .cornerRadius(14)
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(myColors.lightGrayColor)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 12)
                            }
                        )
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.searchText = ""
                                isLoadingAsset = false
                                hideKeyboard()
                                presentationMode.wrappedValue.dismiss()
                                stockSearchResultVM.stockSearchResult.removeAll()
                                stockSearchResultVM.searchStockAsync()
                                
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
                            
                            if(!stockSearchResultVM.stockSearchResult.isEmpty){
                                
                                ScrollView{
                                    LazyVStack{
                                        ForEach(stockSearchResultVM.stockSearchResult, id: \.self){ stock in
                                            NavigationLink(
                                                destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: stock.stockId, stock: nil)
                                                    .environmentObject(userAuth)
                                                    .environmentObject(stockWatchListVM)
                                                    .environmentObject(stockHoldingsVM)
                                                    .environmentObject(stockSearchResultVM)
                                                    .environmentObject(stockOrderVM)
                                                    .environmentObject(userWalletVM)
                                                    .onDisappear(perform: {
                                                        stockWatchListVM.updateStockWatchListAsync()
                                                        stockHoldingsVM.getStockHoldingsAsync()
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
                        VStack{
                            ScrollView{
                                VStack(spacing: 0){
                                    PullToRefreshView(onRefresh:{
                                        isLoadingWatchlist = true
                                        stockWatchListVM.updateStockWatchList(){
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
                                
                                if(!stockWatchListVM.stockWatchList.isEmpty){
                                    LazyVStack {
                                        ForEach(stockWatchListVM.stockWatchList, id: \.self){ stock in
                                            NavigationLink(
                                                destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: 0, stock: stock)
                                                    .environmentObject(userAuth)
                                                    .environmentObject(stockWatchListVM)
                                                    .environmentObject(stockHoldingsVM)
                                                    .environmentObject(stockSearchResultVM)
                                                    .environmentObject(stockOrderVM)
                                                    .environmentObject(userWalletVM)
                                                
                                                    .onDisappear(perform: {
                                                    stockWatchListVM.updateStockWatchListAsync()
                                                    stockHoldingsVM.getStockHoldingsAsync()
                                                }),
                                                tag: stock.id.uuidString,
                                                selection: $selectedItem,
                                                label: {StockSymbolView(stock: stock)})
                                            
                                        }
                                    }.padding(.horizontal)
                                    
                                    
                                }
                                else if(stockWatchListVM.stockWatchList.isEmpty && !isLoadingWatchlist){
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
                                        Text("Surely, there are some assets you would like to track here. Use the search bar above to browse and search for stocks to add to your watchlist")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                            .bold()
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                Spacer()
                            }
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
            }
            .onAppear(perform: {
                onLoad()
            })
            //                .onReceive(self.stockRefreshtimer, perform: { _ in
            //                    shouldRefreshWatchlist = true
            //                })
            .if(!stockWatchListVM.didStockWatchlistLoad){
                view in
                view.redacted(when: true, redactionType: .customPlaceholder)
            }
            .banner(data: $stockWatchListVM.bannerData, show: $stockWatchListVM.showBanner)
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
                        TextField("Tap to Search For Crypto", text: $searchText){ isEditing in
                            if(isEditing){
                                self.isEditing = isEditing
                            }
                        } onCommit: {
                            isLoadingAsset = true
                            cryptoSearchResultVM.searchCrypto(cryptoToSearch: searchText){
                                result in
                                if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        cryptoSearchResultVM.cryptoSearchResult = result.cryptoSearchResponse
                                    }
                                }
                                isLoadingAsset = false
                            }
                        }
                        .disableAutocorrection(true)
                        .padding()
                        .padding(.horizontal, 24)
                        .background(myColors.grayColor)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .cornerRadius(14)
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(myColors.lightGrayColor)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 12)
                            }
                        )
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.searchText = ""
                                isLoadingAsset = false
                                hideKeyboard()
                                presentationMode.wrappedValue.dismiss()
                                cryptoSearchResultVM.cryptoSearchResult.removeAll()
                                cryptoSearchResultVM.populateCryptoListAsync()
                                
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
                            
                            if(!cryptoSearchResultVM.cryptoSearchResult.isEmpty){
                                
                                ScrollView{
                                    LazyVStack{
                                        ForEach(cryptoSearchResultVM.cryptoSearchResult, id: \.self){ crypto in
                                            NavigationLink(
                                                destination: CryptoInfoPageView(cryptoToSearch: crypto.cryptoId, crypto: nil, cryptoQuote: nil)
                                                    .environmentObject(userAuth)
                                                    .environmentObject(cryptoWatchListVM)
                                                    .environmentObject(cryptoSearchResultVM)
                                                    .environmentObject(cryptoHoldingsVM)
                                                    .environmentObject(cryptoOrderVM)
                                                    .environmentObject(userWalletVM)
                                                
                                                
                                                    .onDisappear(perform: {
                                                        cryptoWatchListVM.updateCryptoWatchListAsync()
                                                        cryptoHoldingsVM.getCryptoHoldingsAsync()
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
                        VStack{
                            ScrollView{
                                VStack(spacing: 0){
                                    PullToRefreshView(onRefresh:{
                                        isLoadingWatchlist = true
                                        cryptoWatchListVM.updateCryptoWatchList(){
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
                                if(!cryptoWatchListVM.cryptoWatchList.isEmpty){
                                    LazyVStack {
                                        ForEach(cryptoWatchListVM.cryptoWatchList, id: \.self){ crypto in
                                            NavigationLink(
                                                destination: CryptoInfoPageView(cryptoToSearch: 0, crypto: crypto, cryptoQuote: userAuth.user.currency == "USD" ? CryptoQuote(crypto.usdQuote) : CryptoQuote(crypto.cadQuote))
                                                    .environmentObject(userAuth)
                                                    .environmentObject(cryptoWatchListVM)
                                                    .environmentObject(cryptoSearchResultVM)
                                                    .environmentObject(cryptoHoldingsVM)
                                                    .environmentObject(cryptoOrderVM)
                                                    .environmentObject(userWalletVM)
                                                     
                                                    .onDisappear(perform: {
                                                    cryptoWatchListVM.updateCryptoWatchListAsync()
                                                    cryptoHoldingsVM.getCryptoHoldingsAsync()
                                                }),
                                                tag: crypto.crypto.id.uuidString,
                                                selection: $selectedItem,
                                                label: {CryptoSymbolView(cryptoSymbol: crypto, cryptoQuote: userAuth.user.currency == "USD" ? CryptoQuote(crypto.usdQuote) : CryptoQuote(crypto.cadQuote))})
                                        }
                                    }.padding(.horizontal)
                                }
                                else if(cryptoWatchListVM.cryptoWatchList.isEmpty && !isLoadingWatchlist){
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
                                        Text("Surely, there are some assets you would like to track in your crypto watchlist. Use the search bar above to browse and search for crypto currencies to add to your watchlist")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                            .bold()
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                Spacer()
                            }
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
            }
            .onAppear(perform: {
                onLoad()
            })
            .onReceive(self.cryptoRefreshtimer, perform: { _ in
                shouldRefreshWatchlist = true
            })
            .if(!cryptoWatchListVM.didCryptoWatchlistLoad){
                view in
                view.redacted(when: true, redactionType: .customPlaceholder)
            }
            .banner(data: $cryptoWatchListVM.bannerData, show: $cryptoWatchListVM.showBanner)
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
        if(isCrypto){
            cryptoHoldingsVM.getCryptoHoldingsAsync()
            if(!cryptoWatchListVM.didCryptoWatchlistLoad){
                isLoadingWatchlist = true
                cryptoWatchListVM.updateCryptoWatchList(){
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
        else{
            stockHoldingsVM.getStockHoldingsAsync()
            if(!stockWatchListVM.didStockWatchlistLoad){
                isLoadingWatchlist = true
                stockWatchListVM.updateStockWatchList(){
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
}

struct StocksWatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetWatchListPage(isCrypto: false)
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
            .environmentObject(StockWatchListVM())
            .environmentObject(CryptoWatchListVM())
            .environmentObject(StockHoldingsVM())
            .environmentObject(CryptoHoldingsVM())
            .environmentObject(StockSearchResultVM())
            .environmentObject(CryptoSearchResultVM())
    }
}
