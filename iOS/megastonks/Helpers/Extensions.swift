//
//  Extensions.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-25.
//

import Foundation
import SwiftUI
import UIKit

extension Double {

    func toString(withFloatingPoints points: Int = 0) -> String {
        return String(self)
    }
     
    func signToString() -> String {
        return String(self >= 0 ? "+" : "-")
    }
    
    
    
    func formatNoDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
    
    func formatPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if(fabs(self) < 0.1){
            numberFormatter.usesSignificantDigits = true
            numberFormatter.minimumSignificantDigits = 5
            numberFormatter.maximumSignificantDigits = 5
        }
        else{
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        }
        return  numberFormatter.string(from: NSNumber(value: self))!
        
    }
    
    func formatForex() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 6
        numberFormatter.maximumFractionDigits = 6
        
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
    
    func abbreviated() -> String {
        let abbrev = "KMBTPE"
        return abbrev
                .enumerated()
                .reversed()
                .reduce(nil as String?) { accum, tuple in
                    let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                    let format = (factor - floor(factor) == 0 ? "%.0f%@" : "%.1f%@")
                    return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
                } ?? String(self)
        }
}


extension Int {
        var abbreviated: String {
            let abbrev = "KMBTPE"
            return abbrev
                .enumerated()
                .reversed()
                .reduce(nil as String?) { accum, tuple in
                    let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
                    let format = (factor - floor(factor) == 0 ? "%.0f%@" : "%.1f%@")
                    return accum ?? (factor >= 1 ? String(format: format, factor, String(tuple.1)) : nil)
                } ?? String(self)
        }
}


extension Color {
 
    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }

    var toBool: Bool {
        return (self as NSString).boolValue
    }
    
    func removingWhitespaces() -> String {
            return components(separatedBy: .whitespaces).joined()
    }
    
    func toDateFormat() -> String {
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFromString = dateFormatter1.date(from: self)

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormatter2.string(from: dateFromString ?? Date())
    }
    
    func toDateTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateToConvert = self
        
        if(dateToConvert.count == 28){//This is because dotnet DateTime.UtcNow returns the Z with the milliseconds but efCore truncates this Z
            dateToConvert.removeLast(9)
        }
        else{
            dateToConvert.removeLast(8)
        }
        
        let dateFromString = dateFormatter.date(from: dateToConvert)

        dateFormatter.dateFormat = "EE, MMM d, yyyy h:mm:ss a"

        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: dateFromString ?? Date())
    }
    
    func toDateTimeFormatShort() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateToConvert = self
        
        if(dateToConvert.count == 28){//This is because dotnet DateTime.UtcNow returns the Z with the milliseconds but efCore truncates this Z
            dateToConvert.removeLast(9)
        }
        else{
            dateToConvert.removeLast(8)
        }
        
        let dateFromString = dateFormatter.date(from: dateToConvert)

        dateFormatter.dateFormat = "MMM d, yyyy h:mma"

        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: dateFromString ?? Date())
    }
    
    func chartDateToLocalDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateToConvert = self
        
        
        let dateFromString = dateFormatter.date(from: dateToConvert)

        dateFormatter.dateFormat = "MMM d, yyyy h:mma"

        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: dateFromString ?? Date())
    }
    
    func getTimeInterval() -> String {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateToConvert = self
        
        if(dateToConvert.count == 28){//This is because dotnet DateTime.UtcNow returns the Z with the milliseconds but efCore truncates this Z
            dateToConvert.removeLast(9)
        }
        else if (dateToConvert.count == 27){
            dateToConvert.removeLast(8)
        }
        else {
            dateToConvert.removeLast(7)
        }
        
        let dateFromString = dateFormatter.date(from: dateToConvert)
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .day, .hour, .minute]
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        
        let timeInterval = formatter.string(from: dateFromString ?? Date(), to: Date()) ?? ""
        
        return (!timeInterval.isEmpty ? "\(timeInterval) ago" : "-")
    }
    

    func containsWhiteSpace() -> Bool {
        
        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)
        
        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
}

extension Notification.Name {
    static let didAuthTokenExpire = Notification.Name("didAuthTokenExpire")
    static let didWalletChange = Notification.Name("didWalletChange")
    static let newMessageReceived = Notification.Name("newMessageReceived")
}

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func redacted(when condition: Bool, redactionType: RedactionType) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: redactionType)
        }
    }

    func redacted(reason: RedactionType?) -> some View {
        self.modifier(Redactable(type: reason))
    }
}
