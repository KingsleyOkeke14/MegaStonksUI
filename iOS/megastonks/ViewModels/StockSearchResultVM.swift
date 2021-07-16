//
//  StockSearchResultVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class StockSearchResultVM: ObservableObject {
    
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    @Published var stockSearchResult:[StockSearchResult]
    
    
    init() {
        self.stockSearchResult = [StockSearchResult]()
        searchStockAsync()
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
}
