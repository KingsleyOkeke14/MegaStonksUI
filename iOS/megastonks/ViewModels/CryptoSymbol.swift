//
//  CryptoSymbol.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-28.
//

import Foundation

struct CryptoSymbol: Identifiable, Hashable {
    var id: UUID = UUID()
    var crypto: Crypto
    var info: CryptoInfo
    var usdQuote : CryptoUSDQuote
    var cadQuote: CryptoCADQuote
    var isInWatchlist, isInPortfolio: Bool
    
    init(_ cryptoResponseElement: CryptoResponse) {
        self.crypto = Crypto(cryptoResponseElement)
        self.info = CryptoInfo(cryptoResponseElement)
        self.usdQuote = CryptoUSDQuote(cryptoResponseElement)
        self.cadQuote = CryptoCADQuote(cryptoResponseElement)
        self.isInWatchlist = cryptoResponseElement.isInWatchlist ?? false
        self.isInPortfolio = cryptoResponseElement.isInPortfolio ?? false
    }
}

struct Crypto : Identifiable, Hashable {
    var id: UUID = UUID()
    var cryptoId: Int
    var name, symbol, slug, dateAdded: String
    var maxSupply: Int
    var circulatingSupply: Double
    var totalSupply, cmcRank: Int
    var lastUpdated: String
    
    init(_ cryptoResponseElement: CryptoResponse) {
        self.cryptoId = cryptoResponseElement.crypto!.id
        self.name = cryptoResponseElement.crypto?.name ?? ""
        self.symbol = cryptoResponseElement.crypto?.symbol ?? ""
        self.slug = cryptoResponseElement.crypto?.slug ?? ""
        self.dateAdded = cryptoResponseElement.crypto?.dateAdded ?? ""
        self.maxSupply = cryptoResponseElement.crypto?.maxSupply ?? 0
        self.circulatingSupply = cryptoResponseElement.crypto?.circulatingSupply ?? 0.0
        self.totalSupply = cryptoResponseElement.crypto?.totalSupply ?? 0
        self.cmcRank = cryptoResponseElement.crypto?.cmcRank ?? 0
        self.lastUpdated = cryptoResponseElement.crypto?.lastUpdated ?? ""
    }
}

struct CryptoInfo : Identifiable, Hashable{
    var id: UUID = UUID()
    var category, infoDescription: String
    var logo: String
    var website, twitter, reddit: String
    
    init(_ cryptoResponseElement: CryptoResponse) {
        self.category = cryptoResponseElement.info?.category ?? ""
        self.infoDescription = cryptoResponseElement.info?.infoDescription ?? ""
        self.logo = cryptoResponseElement.info?.logo ?? ""
        self.website = cryptoResponseElement.info?.website ?? ""
        self.twitter = cryptoResponseElement.info?.twitter ?? ""
        self.reddit = cryptoResponseElement.info?.reddit ?? ""
    }
}

struct CryptoUSDQuote : Identifiable, Hashable{
    var id: UUID = UUID()
    var price, volume24H, percentChange1H, percentChange24H: Double
    var percentChange7D, percentChange30D, percentChange60D, percentChange90D: Double
    var marketCap: Double
    
    init(_ cryptoResponseElement: CryptoResponse) {
        self.price = cryptoResponseElement.usdQuote?.price ?? 0.0
        self.volume24H = cryptoResponseElement.usdQuote?.volume24H ?? 0.0
        self.percentChange1H = cryptoResponseElement.usdQuote?.percentChange1H ?? 0.0
        self.percentChange24H = cryptoResponseElement.usdQuote?.percentChange24H ?? 0.0
        self.percentChange7D = cryptoResponseElement.usdQuote?.percentChange7D ?? 0.0
        self.percentChange30D = cryptoResponseElement.usdQuote?.percentChange30D ?? 0.0
        self.percentChange60D = cryptoResponseElement.usdQuote?.percentChange60D ?? 0.0
        self.percentChange90D = cryptoResponseElement.usdQuote?.percentChange90D ?? 0.0
        self.marketCap = cryptoResponseElement.usdQuote?.marketCap ?? 0.0
    }
}

struct CryptoCADQuote : Identifiable, Hashable{
    var id: UUID = UUID()
    var price, volume24H, percentChange1H, percentChange24H: Double
    var percentChange7D, percentChange30D, percentChange60D, percentChange90D: Double
    var marketCap: Double
    
    init(_ cryptoResponseElement: CryptoResponse) {
        self.price = cryptoResponseElement.cadQuote?.price ?? 0.0
        self.volume24H = cryptoResponseElement.cadQuote?.volume24H ?? 0.0
        self.percentChange1H = cryptoResponseElement.cadQuote?.percentChange1H ?? 0.0
        self.percentChange24H = cryptoResponseElement.cadQuote?.percentChange24H ?? 0.0
        self.percentChange7D = cryptoResponseElement.cadQuote?.percentChange7D ?? 0.0
        self.percentChange30D = cryptoResponseElement.cadQuote?.percentChange30D ?? 0.0
        self.percentChange60D = cryptoResponseElement.cadQuote?.percentChange60D ?? 0.0
        self.percentChange90D = cryptoResponseElement.cadQuote?.percentChange90D ?? 0.0
        self.marketCap = cryptoResponseElement.cadQuote?.marketCap ?? 0.0
    }
}

struct CryptoQuote{
    var price, volume24H, percentChange1H, percentChange24H: Double
    var percentChange7D, percentChange30D, percentChange60D, percentChange90D: Double
    var change1H, change24H, change7D, change30D, change60D, change90D: Double
    var marketCap: Double
    
    init(_ cryptoQuoteElement: CryptoUSDQuote) {
        self.price = cryptoQuoteElement.price
        self.volume24H = cryptoQuoteElement.volume24H
        self.percentChange1H = cryptoQuoteElement.percentChange1H
        self.percentChange24H = cryptoQuoteElement.percentChange24H
        self.percentChange7D = cryptoQuoteElement.percentChange7D
        self.percentChange30D = cryptoQuoteElement.percentChange30D
        self.percentChange60D = cryptoQuoteElement.percentChange60D
        self.percentChange90D = cryptoQuoteElement.percentChange90D
        self.change1H = (((cryptoQuoteElement.percentChange1H / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change24H = (((cryptoQuoteElement.percentChange24H / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change7D = (((cryptoQuoteElement.percentChange7D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change30D = (((cryptoQuoteElement.percentChange30D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change60D = (((cryptoQuoteElement.percentChange60D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change90D = (((cryptoQuoteElement.percentChange90D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.marketCap = cryptoQuoteElement.marketCap
    }
    
    init(_ cryptoQuoteElement: CryptoCADQuote) {
        self.price = cryptoQuoteElement.price
        self.volume24H = cryptoQuoteElement.volume24H
        self.percentChange1H = cryptoQuoteElement.percentChange1H
        self.percentChange24H = cryptoQuoteElement.percentChange24H
        self.percentChange7D = cryptoQuoteElement.percentChange7D
        self.percentChange30D = cryptoQuoteElement.percentChange30D
        self.percentChange60D = cryptoQuoteElement.percentChange60D
        self.percentChange90D = cryptoQuoteElement.percentChange90D
        self.change1H = (((cryptoQuoteElement.percentChange1H / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change24H = (((cryptoQuoteElement.percentChange24H / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change7D = (((cryptoQuoteElement.percentChange7D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change30D = (((cryptoQuoteElement.percentChange30D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change60D = (((cryptoQuoteElement.percentChange60D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.change90D = (((cryptoQuoteElement.percentChange90D / 100) * cryptoQuoteElement.price) + cryptoQuoteElement.price)
        self.marketCap = cryptoQuoteElement.marketCap
    }
}

struct CryptoSymbols{
    var cryptos: [CryptoSymbol] = [CryptoSymbol]()
    
    init(cryptoArray:[CryptoResponse]){
        
        for crypto in cryptoArray{
            
            let cryptoToAdd = CryptoSymbol(crypto)
            cryptos.append(cryptoToAdd)
        }
    }
}
