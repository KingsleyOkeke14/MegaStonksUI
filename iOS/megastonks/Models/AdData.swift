//
//  AdData.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-04.
//

import Foundation

struct AdDataElement: Identifiable, Hashable{
    var id: UUID = UUID()
    var title: String
    var description: String
    var imageUrl: String
    var urlToLoad: String
    
    init(_ adResponseElement: AdsResponseElement) {
        self.title = adResponseElement.title ?? ""
        self.description = adResponseElement.adsResponseDescription ?? ""
        self.imageUrl = adResponseElement.imageURL ?? ""
        self.urlToLoad = adResponseElement.urlToLoad ?? ""
    }
}

struct AdData {
    var ads: [AdDataElement] = [AdDataElement]()
    
    init(_ adsArray: [AdsResponseElement]) {
        for ad in adsArray{
            
            let adToAppend = AdDataElement(ad)
            ads.append(adToAppend)
        }
        ads.shuffle()
    }
}
