//
//  AppEnvironmentObjects.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation

class AppObjects: ObservableObject {
    @Published var stockWatchList: [StockSymbol]
    @Published var cryptoWatchList: [CryptoSymbol]
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    @Published var stockSearchResult:[StockSearchResult]
    @Published var cryptoSearchResult:[CryptoSearchResult]
    @Published var userWallet:UserWallet
    @Published var stockHoldings:StockHoldings
    @Published var cryptoHoldings:CryptoHoldings
    @Published var orderStockHistory: OrderStockHistory
    @Published var orderCryptoHistory: OrderCryptoHistory
    @Published var ads: [AdDataElement]
    @Published var randomAdIndex: Int
    @Published var news: [NewsElement]
    @Published var notificationManager = LocalNotificationManager()
    @Published var didStockWatchlistLoad:Bool = false
    @Published var didCryptoWatchlistLoad:Bool = false
    
    
    init() {
        
        self.stockWatchList = [StockSymbol]()
        self.cryptoWatchList = [CryptoSymbol]()
        self.stockSearchResult = [StockSearchResult]()
        self.cryptoSearchResult = [CryptoSearchResult]()
        self.userWallet = UserWallet(WalletResponse(firstName: "", lastName: "", cash: 0.0, initialDeposit: 0.0, investments: 0.0, total: 0.0, percentReturnToday: 0.0, moneyReturnToday: 0.0, percentReturnTotal: 0.0, moneyReturnTotal: 0.0))
        self.stockHoldings = StockHoldings(holdingsArray: [StockHoldingsResponseElement]())
        self.cryptoHoldings = CryptoHoldings(holdingsArray: [CryptoHoldingsResponseElement]())
        self.orderStockHistory = OrderStockHistory(orderArray: [OrderStockHistoryResponseElement]())
        self.orderCryptoHistory = OrderCryptoHistory(orderArray: [OrderCryptoResponse]())
        self.ads = [AdDataElement]()
        self.news = [NewsElement]()
        self.randomAdIndex = 0
        API().GetAds(){
            result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(AdsResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.ads  = AdData(jsonResponse).ads
                    }
                }
            }
        }
        updateStockWatchList(){ result in
            if(result.isSuccessful){
                print("Stock Watchlist Loaded First Time")
            }else{
                print("Error Loading Stock Watchlist First Time")
            }
            DispatchQueue.main.async {
                self.didStockWatchlistLoad = true  //This is used to check if the objects that are in this init are loaded when the app is started
            }
   
           
        }
        updateCryptoWatchList(){ result in
            if(result.isSuccessful){
                print("Stock Watchlist Loaded First Time")
            }else{
                print("Error Loading Crypto Watchlist First Time")
            }
            DispatchQueue.main.async {
                self.didCryptoWatchlistLoad = true  //This is used to check if the objects that are in this init are loaded when the app is started
            }
        }
       getNewsAsync()
       searchStockAsync()
       populateCryptoListAsync()
       
    }
    
    func updateStockWatchList(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetWatchList(isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockListResponse.self, from: result.data!) {
                    response.stockWatchListResponse = StockSymbols(stockElementArray: jsonResponse).stocks
                    response.isSuccessful = true
                        DispatchQueue.main.async {
                            self.stockWatchList = response.stockWatchListResponse.reversed()
                        }
                    
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Updating Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
            completion(response)
        }
    }
    
    func updateStockWatchListAsync() {
        var response = RequestResponse()
        API().GetAssetWatchList(isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockListResponse.self, from: result.data!) {
                    response.stockWatchListResponse = StockSymbols(stockElementArray: jsonResponse).stocks
                    if(response.stockWatchListResponse.count != self.stockWatchList.count){
                        DispatchQueue.main.async {
                            self.stockWatchList = response.stockWatchListResponse.reversed()
                        }
                    }

                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Updating Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func updateCryptoWatchList(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetWatchList(isCrypto: true){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode([CryptoResponse].self, from: result.data!) {
                    response.cryptoWatchListResponse = CryptoSymbols(cryptoArray: jsonResponse).cryptos
                    response.isSuccessful = true
                        DispatchQueue.main.async {
                            self.cryptoWatchList = response.cryptoWatchListResponse.reversed()
                        }
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Updating Crypto Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
            completion(response)
        }
    }
    
    func updateCryptoWatchListAsync() {
        var response = RequestResponse()
        API().GetAssetWatchList(isCrypto: true){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode([CryptoResponse].self, from: result.data!) {
                    response.cryptoWatchListResponse = CryptoSymbols(cryptoArray: jsonResponse).cryptos
                    if(response.cryptoWatchListResponse.count != self.cryptoWatchList.count){
                        DispatchQueue.main.async {
                            self.cryptoWatchList = response.cryptoWatchListResponse.reversed()
                        }
                    }
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Updating Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func searchStockAsync(stockToSearch: String = "DOC") {
        var response = RequestResponse()
        API().SearchAsset(isCrypto: false, textToSearch: stockToSearch){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockSearchResponse.self, from: result.data!) {
                    response.stockSearchResponse = StockSearchResults(stockElementArray: jsonResponse).stocks
                        DispatchQueue.main.async {
                            self.stockSearchResult = response.stockSearchResponse
                        }
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error getting stock data requested. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func populateCryptoListAsync() {
        var response = RequestResponse()
        API().GetCryptoInSchema{ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CryptoSearchResponse.self, from: result.data!) {
                    response.cryptoSearchResponse = CryptoSearchResults(cryptoElemetArray: jsonResponse).cryptos
                        DispatchQueue.main.async {
                            self.cryptoSearchResult = response.cryptoSearchResponse
                        }
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error getting crypto data requested. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func searchStock(stockToSearch: String, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().SearchAsset(isCrypto: false, textToSearch: stockToSearch){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockSearchResponse.self, from: result.data!) {
                    response.stockSearchResponse = StockSearchResults(stockElementArray: jsonResponse).stocks
                    response.isSuccessful = true
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error getting stock data requested. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
            completion(response)
        }
    }
    
    func searchCrypto(cryptoToSearch: String, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().SearchAsset(isCrypto: true, textToSearch: cryptoToSearch){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CryptoSearchResponse.self, from: result.data!) {
                    response.cryptoSearchResponse = CryptoSearchResults(cryptoElemetArray: jsonResponse).cryptos
                    response.isSuccessful = true
                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error getting crypto data requested. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
            completion(response)
        }
    }
    
    func addStockToWatchListAsync(stockToAdd: Int) {
        var response = RequestResponse()
        API().AddAssetToWatchList(assetId: stockToAdd, isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!) {
                    response.errorMessage = jsonResponse.message
                    DispatchQueue.main.async {
                        self.bannerData.detail = jsonResponse.message
                        self.bannerData.type = .Info
                        self.showBanner = true
                    }

                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Adding Stock to Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func addCryptoToWatchListAsync(cryptoToAdd: Int) {
        var response = RequestResponse()
        API().AddAssetToWatchList(assetId: cryptoToAdd, isCrypto: true){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!) {
                    response.errorMessage = jsonResponse.message
                    DispatchQueue.main.async {
                        self.bannerData.detail = jsonResponse.message
                        self.bannerData.type = .Info
                        self.showBanner = true
                    }

                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Adding Crypto to Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func removeStockFromWatchListAsync(stockToRemove: Int) {
        var response = RequestResponse()
        API().RemoveAssetFromWatchList(assetId: stockToRemove, isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!) {
                    response.errorMessage = jsonResponse.message
                    DispatchQueue.main.async {
                        self.bannerData.detail = jsonResponse.message
                        self.bannerData.type = .Info
                        self.showBanner = true
                    }

                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Removing Stock from Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func removeCryptoFromWatchListAsync(cryptoToRemove: Int) {
        var response = RequestResponse()
        API().RemoveAssetFromWatchList(assetId: cryptoToRemove, isCrypto: true){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!) {
                    response.errorMessage = jsonResponse.message
                    DispatchQueue.main.async {
                        self.bannerData.detail = jsonResponse.message
                        self.bannerData.type = .Info
                        self.showBanner = true
                    }

                }
                 else{
                    DispatchQueue.main.async {
                        self.bannerData.detail = "Error Removing Crypto from Watchlist. Please contact Support if the problem persists. (hello@megastonks.com)"
                        self.bannerData.type = .Error
                        self.showBanner = true
                    }
                 }
                
            }
            
            else{
                DispatchQueue.main.async {
                    self.bannerData.detail = result.errorMessage
                    self.bannerData.type = .Warning
                    self.showBanner = true
                }
            }
        }
    }
    
    func getStockInfo(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetInfo(assetId: stockId, isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockElementResponse.self, from: result.data!) {
                    response.stockInfoSearchStocksPage = StockSymbol(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getCryptoInfo(cryptoId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetInfo(assetId: cryptoId, isCrypto: true){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(CryptoResponse.self, from: result.data!){
                    response.cryptoInfoSearchCryptosPage = CryptoSymbol(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getStockHolding(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHolding(assetId: stockId, isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingResponseInfoPage.self, from: result.data!) {
                    response.holdingInfoPageResponse = HoldingInfoPage(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getStockHoldingsAsync() {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(stockHoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                    if(self.shouldStockholdingsUpdate(response.stockHoldingsResponse!, self.stockHoldings)){
                        DispatchQueue.main.async {
                            self.stockHoldings = response.stockHoldingsResponse!
                        }
                    }
                }
            }
        }
    }
    
    func getStockHoldings(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(stockHoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getCryptoHolding(cryptoId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHolding(assetId: cryptoId, isCrypto: true){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingResponseInfoPage.self, from: result.data!) {
                    response.holdingInfoPageResponse = HoldingInfoPage(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getCryptoHoldingsAsync() {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: true){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode([CryptoHoldingsResponseElement].self, from: result.data!) {
                    response.cryptoHoldingsResponse = CryptoHoldings(holdingsArray: jsonResponse)
                    if(self.shouldCryptoholdingsUpdate(response.cryptoHoldingsResponse!, self.cryptoHoldings)){
                        DispatchQueue.main.async {
                            self.cryptoHoldings = response.cryptoHoldingsResponse!
                        }
                    }
                }
            }
        }
    }
    
    func getCryptoHoldings(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: true){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode([CryptoHoldingsResponseElement].self, from: result.data!) {
                    response.cryptoHoldingsResponse = CryptoHoldings(holdingsArray: jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getStockPriceChart(stockId: Int, interval: String = "5Y", isPriceHistory: Bool = true, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().GetStockPriceChart(stockId: stockId, interval: interval, isPriceHistory: isPriceHistory){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(ChartDataResponse.self, from: result.data!) {
                    response.chartDataResponse = ChartData(jsonResponse, isCrypto: false)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getCryptoPriceChart(cryptoId: Int, isPriceHistory: Bool = true, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().GetCryptoPriceChart(cryptoId: cryptoId, isPriceHistory: isPriceHistory){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(ChartDataResponse.self, from: result.data!) {
                    response.chartDataResponse = ChartData(jsonResponse, isCrypto: true)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getWalletAsync() {
        API().GetWallet(){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(WalletResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.userWallet  = UserWallet(jsonResponse)
                    }
                }
            }
        }
    }
    
    func getWallet(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetWallet(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(WalletResponse.self, from: result.data!) {
                    response.walletResponse  = UserWallet(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    
    func getStockOrderHistoryAsync() {
        API().GetOrderHistory(isCrypto: false){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(OrderStockHistoryResponse.self, from: result.data!) {
                    if(jsonResponse.count != self.orderStockHistory.history.count){
                        DispatchQueue.main.async {
                            self.orderStockHistory  = OrderStockHistory(orderArray: jsonResponse)
                        }
                    }

                }
            }
        }
    }
    
    func getCryptoOrderHistoryAsync() {
        API().GetOrderHistory(isCrypto: true){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(OrderCryptoHistoryResponse.self, from: result.data!) {
                    if(jsonResponse.count != self.orderCryptoHistory.history.count){
                        DispatchQueue.main.async {
                            self.orderCryptoHistory  = OrderCryptoHistory(orderArray: jsonResponse)
                        }
                    }

                }
            }
        }
    }
    
    func orderStock(stockId:Int, orderType:String, orderAction:String, quantitySubmitted: Int, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().OrderStock(stockId: stockId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(OrderStockResponse.self, from: result.data!) {
                    response.orderStockResponse = OrderStockResultInfo(orderResponse: jsonResponse)
                    response.isSuccessful = true
               }
            }
            completion(response)
        }
    }
    
    func orderCrypto(cryptoId:Int, orderType:String, orderAction:String, quantitySubmitted: Double, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().OrderCrypto(cryptoId: cryptoId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(OrderCryptoResponse.self, from: result.data!) {
                    response.orderCryptoResponse = OrderCryptoResultInfo(orderResponse: jsonResponse)
                    response.isSuccessful = true
               }
            }
            completion(response)
        }
    }
    
    
    func getAdsAsync() {
        API().GetAds(){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(AdsResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.ads  = AdData(jsonResponse).ads
                    }
                }
            }
        }
    }
    
    func getNews(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetNews(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
                    response.isSuccessful = true
                    if(response.newsResponse!.count <= 0){
                        response.isSuccessful = false
                    }
                }
            }
            completion(response)
        }
    }
    
    func getNewsAsync() {
        var response = RequestResponse()
        API().GetNews(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
                    if(response.newsResponse!.count <= 0){
                        response.isSuccessful = false
                    }
                    else{
                        response.isSuccessful = true
                        DispatchQueue.main.async {
                            self.news  = News(jsonResponse).news
                        }
                    }
                }
            }
        }
    }
    
    func updateRandomAdIndex(){
        if(self.ads.count > 1){
            let randomIndex = Int.random(in: 0..<self.ads.count)
            DispatchQueue.main.async {
                self.randomAdIndex = randomIndex
            }
        }
    }
    
    private func shouldStockholdingsUpdate(_ incomingStockHoldings: StockHoldings, _ stockHoldings: StockHoldings) -> Bool{
        
        if(incomingStockHoldings.holdings.count != stockHoldings.holdings.count){
            return true
        }
        return false
    }
    private func shouldCryptoholdingsUpdate(_ incomingCryptoHoldings: CryptoHoldings, _ cryptoHoldings: CryptoHoldings) -> Bool{
        
        if(incomingCryptoHoldings.holdings.count != cryptoHoldings.holdings.count){
            return true
        }
        return false
    }
    
    
}
