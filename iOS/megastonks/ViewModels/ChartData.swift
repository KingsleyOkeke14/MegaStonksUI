//
//  ChartData.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-28.
//

import Foundation


struct ChartData {
    var dataSet:[(String, Double)] = [(String, Double)]()
    
    init(_ chartData:ChartDataResponse, isCrypto: Bool) {
        if isCrypto {
            for data in chartData{
                dataSet.append((data.date?.chartDateToLocalDate() ?? "", data.close ?? 0.0))
            }
        }
        else{
            for data in chartData{
                 dataSet.append((data.date ?? "", data.close ?? 0.0))
            }
            dataSet.reverse()
        }

    }
}
