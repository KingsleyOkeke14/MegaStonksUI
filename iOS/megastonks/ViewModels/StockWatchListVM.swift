//
//  WatchListViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class StockWatchListVM: ObservableObject {
    @Published var stockWatchList: [StockSymbol]
    @Published var didStockWatchlistLoad:Bool = false
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    
    init() {
        self.stockWatchList = [StockSymbol]()
        
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
    
    
}
