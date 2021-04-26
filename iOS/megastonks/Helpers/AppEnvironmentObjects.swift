//
//  AppEnvironmentObjects.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation

class WatchListObject: ObservableObject {
    @Published var watchList: [StockSymbol]
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    
    
    init() {
        
        self.watchList = [StockSymbol]()
        
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
