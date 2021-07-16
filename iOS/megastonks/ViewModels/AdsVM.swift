//
//  AdsVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class AdsVM: ObservableObject {
    
    @Published var randomAdIndex: Int
    @Published var ads: [AdDataElement]
    
    init() {
        self.randomAdIndex = 0
        self.ads = [AdDataElement]()
        API().GetAds(){
            result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(AdsResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.ads  = AdData(jsonResponse).ads
                    }
                }
            }
        }
    }
    
    func getAdsAsync() {
        API().GetAds(){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(AdsResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.ads  = AdData(jsonResponse).ads
                    }
                }
            }
        }
    }
    
    func updateRandomAdIndex(){
        if(self.ads.count > 1){
            let randomIndex = Int.random(in: 0..<self.ads.count)
            DispatchQueue.main.async {
                self.randomAdIndex = randomIndex
            }
        }
    }
}
