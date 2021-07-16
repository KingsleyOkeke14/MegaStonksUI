//
//  CryptoSearchResult.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-31.
//

import Foundation

struct CryptoSearchResult: Identifiable, Hashable{
    var id:UUID = UUID()
    var cryptoId: Int
    var name, symbol, slug, dateAdded: String
    var circulatingSupply, totalSupply: Double
    var cmcRank: Int
    var lastUpdated: String
    var maxSupply: Int
    
    init(_ cryptoElement:CryptoSearchResponseElement){
        self.cryptoId = cryptoElement.id
        self.name = cryptoElement.name ?? ""
        self.symbol = cryptoElement.symbol ?? ""
        self.slug = cryptoElement.slug ?? ""
        self.dateAdded = cryptoElement.dateAdded ?? ""
        self.circulatingSupply = cryptoElement.circulatingSupply ?? 0.0
        self.totalSupply = cryptoElement.totalSupply ?? 0.0
        self.cmcRank = cryptoElement.cmcRank ?? 0
        self.lastUpdated = cryptoElement.lastUpdated ?? ""
        self.maxSupply = cryptoElement.maxSupply ?? 0
        
    }
}

struct CryptoSearchResults{
    
    var cryptos: [CryptoSearchResult] = [CryptoSearchResult]()
    
    init(cryptoElemetArray:[CryptoSearchResponseElement]){
        
        for crypto in cryptoElemetArray{
            
            let cryptoToAdd = CryptoSearchResult(crypto)
            cryptos.append(cryptoToAdd)
        }
    }
}
