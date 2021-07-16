//
//  CryptoSearchResultVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class CryptoSearchResultVM: ObservableObject {
    
    @Published var cryptoSearchResult:[CryptoSearchResult]
    @Published var showBanner:Bool = false
    @Published var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    
    init() {
        self.cryptoSearchResult = [CryptoSearchResult]()
        populateCryptoListAsync()
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
}
