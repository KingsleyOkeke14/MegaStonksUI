//
//  CryptoWatchListViewModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class CryptoWatchListVM: ObservableObject {
    
    @Published var cryptoWatchList: [CryptoSymbol]
    @Published var didCryptoWatchlistLoad:Bool = false
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    
    init() {
        self.cryptoWatchList = [CryptoSymbol]()
        
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
    
    
}
