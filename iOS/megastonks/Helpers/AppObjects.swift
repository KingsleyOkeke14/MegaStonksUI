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
    
    
    init() {
        
        self.watchList = [StockSymbol]()
        self.stockSearchResult = [StockSearchResult]()
        SearchStockAsync()
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
                        self.watchList = response.watchListResponse
                    }
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
                            self.watchList = response.watchListResponse
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
    
    func SearchStockAsync(stockToSearch: String = "DOC") {
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
    
    func SearchStock(stockToSearch: String, completion: @escaping (RequestResponse) -> ()) {
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
}
