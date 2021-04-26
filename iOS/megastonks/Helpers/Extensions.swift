//
//  Extensions.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation

extension Double {

    func toString(withFloatingPoints points: Int = 0) -> String {
        return String(self)
    }
    
    func formatPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
    
    func formatPercentChange() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.positivePrefix = numberFormatter.plusSign
        
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension Notification.Name {
    static let didAuthTokenExpire = Notification.Name("didAuthTokenExpire")
}
