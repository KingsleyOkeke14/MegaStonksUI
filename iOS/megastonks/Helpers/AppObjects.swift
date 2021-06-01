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
    @Published var userWallet:UserWallet
    @Published var holdings:StockHoldings
    @Published var orderHistory: OrderHistory
    @Published var ads: [AdDataElement]
    @Published var randomAdIndex: Int
    @Published var news: [NewsElement]
    
    
    init() {
        
        self.stockWatchList = [StockSymbol]()
        self.cryptoWatchList = [CryptoSymbol]()
        self.stockSearchResult = [StockSearchResult]()
        self.userWallet = UserWallet(WalletResponse(firstName: "", lastName: "", cash: 0.0, initialDeposit: 0.0, investments: 0.0, total: 0.0, percentReturnToday: 0.0, moneyReturnToday: 0.0, percentReturnTotal: 0.0, moneyReturnTotal: 0.0))
        self.holdings = StockHoldings(holdingsArray: [StockHoldingsResponseElement]())
        self.orderHistory = OrderHistory(orderArray: [OrderHistoryResponseElement]())
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
       getNewsAsync()
       searchStockAsync()
    }
    
    func updateStockWatchList(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetWatchList(isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockListResponse.self, from: result.data!) {
                    response.stockWatchListResponse = StockSymbols(stockElementArray: jsonResponse).stocks
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
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode([CryptoResponse].self, from: result.data!) {
                    response.cryptoWatchListResponse = CryptoSymbols(cryptoArray: jsonResponse).cryptos
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
    
    func searchStock(stockToSearch: String, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().SearchAsset(isCrypto: false, textToSearch: stockToSearch){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockSearchResponse.self, from: result.data!) {
                    response.stockSearchResponse = StockSearchResults(stockElementArray: jsonResponse).stocks
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
        API().GetStockInfo(stockId: stockId){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockElementResponse.self, from: result.data!) {
                    response.stockInfoSearchStocksPage = StockSymbol(jsonResponse)
                }
            }
            completion(response)
        }
    }
    
    func getStockHolding(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetStockHolding(stockId: stockId){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingResponseInfoPage.self, from: result.data!) {
                    response.stockHoldingInfoPageResponse = StockHoldingInfoPage(jsonResponse)
                }
            }
            completion(response)
        }
    }
    
    func getStockHoldingsAsync() {
        var response = RequestResponse()
        API().GetStockHoldings(){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                    if(self.shouldStockholdingsUpdate(response.stockHoldingsResponse!, self.holdings)){
                        DispatchQueue.main.async {
                            self.holdings = response.stockHoldingsResponse!
                        }
                    }
                }
            }
        }
    }
    
    func getStockHoldings(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetStockHoldings(){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                }
            }
            completion(response)
        }
    }
    
    
    func getPriceChart(stockId: Int, interval: String = "5Y", isPriceHistory: Bool = true, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().GetPriceChart(stockId: stockId, interval: interval, isPriceHistory: isPriceHistory){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(ChartDataResponse.self, from: result.data!) {
                    response.stockChartDataResponse = ChartData(jsonResponse)
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
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(WalletResponse.self, from: result.data!) {
                    response.walletResponse  = UserWallet(jsonResponse)
                }
            }
            completion(response)
        }
    }
    
    
    func getOrderHistoryAsync() {
        API().GetOrderHistory(){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(OrderHistoryResponse.self, from: result.data!) {
                    if(jsonResponse.count != self.orderHistory.history.count){
                        DispatchQueue.main.async {
                            self.orderHistory  = OrderHistory(orderArray: jsonResponse)
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
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(OrderStockResponse.self, from: result.data!) {
                    response.orderStockResponse = OrderResultInfo(orderResponse: jsonResponse)
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
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
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
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
                    if(response.newsResponse!.count <= 0){
                        response.isSuccessful = false
                    }
                    else{
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
    
    func shouldStockholdingsUpdate(_ incomingStockHoldings: StockHoldings, _ stockHoldings: StockHoldings) -> Bool{
        
        if(incomingStockHoldings.holdings.count != stockHoldings.holdings.count){
            return true
        }
        return false
    }
    
    
}
