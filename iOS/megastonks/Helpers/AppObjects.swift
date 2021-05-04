//
//  AppEnvironmentObjects.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation

class AppObjects: ObservableObject {
    @Published var watchList: [StockSymbol]
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    @Published var stockSearchResult:[StockSearchResult]
    @Published var userWallet:UserWallet
    @Published var holdings:StockHoldings
    @Published var orderHistory: OrderHistory
    
    
    init() {
        
        self.watchList = [StockSymbol]()
        self.stockSearchResult = [StockSearchResult]()
        self.userWallet = UserWallet(WalletResponse(firstName: "", lastName: "", cash: 0.0, initialDeposit: 0.0, investments: 0.0, total: 0.0, percentReturnToday: 0.0, moneyReturnToday: 0.0, percentReturnTotal: 0.0, moneyReturnTotal: 0.0))
        self.holdings = StockHoldings(holdingsArray: [HoldingsResponseElement]())
        self.orderHistory = OrderHistory(orderArray: [OrderHistoryResponseElement]())
    }
    
    func updateWatchList(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetWatchList(){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockListResponse.self, from: result.data!) {
                    response.watchListResponse = StockSymbols(stockElementArray: jsonResponse).stocks
                        DispatchQueue.main.async {
                            self.watchList = response.watchListResponse.reversed()
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
    
    func updateWatchListAsync() {
        var response = RequestResponse()
        API().GetWatchList(){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(StockListResponse.self, from: result.data!) {
                    response.watchListResponse = StockSymbols(stockElementArray: jsonResponse).stocks
                    if(response.watchListResponse.count != self.watchList.count){
                        DispatchQueue.main.async {
                            self.watchList = response.watchListResponse.reversed()
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
        API().SearchStock(textToSearch: stockToSearch){ result in
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
        API().SearchStock(textToSearch: stockToSearch){ result in
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
        API().AddStockToWatchList(stockId: stockToAdd){ result in
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
    
    func removeStockFromWatchListAsync(stockToRemove: Int) {
        var response = RequestResponse()
        API().RemoveStockFromWatchList(stockId: stockToRemove){ result in
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
                    
                    DispatchQueue.main.async {
                        self.holdings = response.stockHoldingsResponse!
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
                    response.chartDataResponse = ChartData(jsonResponse)
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
}
