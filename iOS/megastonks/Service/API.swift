//
//  API.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-28.
//

import Foundation
import SwiftKeychainWrapper

struct APIRoutes {
    private let server:String
    let domain = "megastonksdev.azurewebsites.net"
    private let authRoute = "accounts/authenticate"
    private let registerRoute = "accounts/register"
    private let watchlistRoute = "watchlist/getwatchlist"
    private let revokeTokenRoute = "accounts/revoke-token"
    private let refreshTokenRoute = "accounts/refresh-token"
    private let forgotPasswordRoute = "accounts/forgot-password"
    private let resetPasswordRoute = "accounts/reset-password"
    private let onBoardRoute = "accounts/onboard-completed"
    private let searchStockRoute = "stocks/searchstock"
    private let addStockRoute = "watchlist/addstock"
    private let removeStockRoute = "watchlist/removestock"
    private let stockInfoRoute = "stocks/stockinfo"
    private let stockHoldingRoute = "stocks/stockholding"
    private let priceChartRoute = "stocks/pricechart"
    private let priceHistoryRoute = "stocks/pricehistory"
    private let isMarketOpenRoute = "fmpApi/ismarketopen"
    private let walletRoute = "wallet"
    
    
    var auth = URL(string: "")
    var register = URL(string: "")
    var watchList = URL(string: "")
    var revokeToken = URL(string: "")
    var refreshToken = URL(string: "")
    var forgotPassword = URL(string: "")
    var resetPassword = URL(string: "")
    var onBoard = URL(string: "")
    var searchStock = URL(string: "")
    var addStock = URL(string: "")
    var removeStock = URL(string: "")
    var stockInfo = URL(string: "")
    var stockHolding = URL(string: "")
    var priceChart = URL(string: "")
    var priceHistory = URL(string: "")
    var isMarketOpen = URL(string: "")
    var wallet = URL(string: "")
    
    init() {
        server = "https://\(domain)/"
        auth = URL(string: server + authRoute)!
        register = URL(string: server + registerRoute)!
        watchList = URL(string: server + watchlistRoute)!
        revokeToken = URL(string: server + revokeTokenRoute)!
        refreshToken = URL(string: server + refreshTokenRoute)!
        forgotPassword = URL(string: server + forgotPasswordRoute)!
        resetPassword = URL(string: server + resetPasswordRoute)!
        onBoard = URL(string: server + onBoardRoute)!
        searchStock = URL(string: server + searchStockRoute)!
        addStock = URL(string: server + addStockRoute)!
        removeStock = URL(string: server + removeStockRoute)!
        stockInfo = URL(string: server + stockInfoRoute)!
        stockHolding = URL(string: server + stockHoldingRoute)!
        priceChart = URL(string: server + priceChartRoute)!
        priceHistory = URL(string: server + priceHistoryRoute)!
        isMarketOpen = URL(string: server + isMarketOpenRoute)!
        wallet = URL(string: server + walletRoute)!
    }
}

struct AppUrlRequest {
    var request:URLRequest
    
    init(url:URL, httpMethod:String) {
        request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
}

struct API{
    let session = URLSession.shared
    let apiRoutes = APIRoutes()
    let decoder = JSONDecoder()
    
    
    func Authenticate(emailAddress: String, password: String, completion: @escaping (RequestResponse) -> ()) {
        
        let request = AppUrlRequest(url: apiRoutes.auth!, httpMethod: "POST").request
        
        
        var result = RequestResponse()
        
        let authRequest = AuthenticateRequest(email: emailAddress, password: password)
        
        let jsonData = try! JSONEncoder().encode(authRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            //if let data = data, let jsonString = String(data: data, encoding: .utf8) {
            //    print(jsonString)
            //}
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                result.isSuccessful = false
                result.errorMessage = "Error contacting the server. Please Check your internet connection"
                completion(result)
                return
            }
            
            
            
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode != 200{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Invalid Credentials. Please try Again"
                    }
                    print("Error Logging In")
                }
                else {
                    result.isSuccessful = true
                    let fields = httpResponse.allHeaderFields as? [String :String]
                    
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields!, for: response!.url!)
                    for cookie in cookies {
                        if(cookie.name == "refreshToken"){
                            let saveSuccessful: Bool = KeychainWrapper.standard.set(cookie.value, forKey: cookie.name)
                            print("KeyChain Store Result is \(saveSuccessful)")
                        }
                        
                    }
                    
                }
            }
            
            
            completion(result)
            print("Attempted Login")
            //print(result.data!)
            //print(response!)
            if result.data != nil {
                
                
                if let jsonResponse = try? decoder.decode(AuthenticateResponse.self, from: result.data!) {
                    KeychainWrapper.standard.set(jsonResponse.jwtToken, forKey: "jwtToken")
                }
                
            }
            
        }
        task.resume()
    }
    
    func RefreshToken(token: String, completion: @escaping (RequestResponse) -> ()) {
        
        let request = AppUrlRequest(url: apiRoutes.refreshToken!, httpMethod: "POST").request
        
        var result = RequestResponse()
        
            
            if let cookie = HTTPCookie(properties: [
                .domain: APIRoutes().domain,
                .path: "/",
                .name: "refreshToken",
                .value: token,
                .secure: "FALSE",
                .discard: "TRUE"
            ]) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
            
            
            let jsonData = try! JSONEncoder().encode("")
            
            let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
                
                
                result.data = data
                
                if error != nil || data == nil {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                
                
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode != 200{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Error Refreshing Token"
                        }
                        print(result.errorMessage)
                    }
                    else {
                        result.isSuccessful = true
                        let fields = httpResponse.allHeaderFields as? [String :String]
                        
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields!, for: response!.url!)
                        for cookie in cookies {
                            if(cookie.name == "refreshToken"){
                                let saveSuccessful: Bool = KeychainWrapper.standard.set(cookie.value, forKey: cookie.name)
                                print("KeyChain Store Result is \(saveSuccessful)")
                            }
                            
                        }
                        
                        if result.data != nil {
                            if let jsonResponse = try? decoder.decode(AuthenticateResponse.self, from: result.data!) {
                                KeychainWrapper.standard.set(jsonResponse.jwtToken, forKey: "jwtToken")
                            }
                            
                        }
                        
                    }
                }
                
                completion(result)
            }
            task.resume()
        
         
    }
    
    func RevokeToken(completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        var revokeTokenRequest: TokenRequest = TokenRequest(token: "")
        var request = AppUrlRequest(url: apiRoutes.revokeToken!, httpMethod: "POST").request
        
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        }
        
        
        if let refreshToken: String = KeychainWrapper.standard.string(forKey: "refreshToken"){
            revokeTokenRequest = TokenRequest(token: refreshToken)
        }
        
        
        let jsonData = try! JSONEncoder().encode(revokeTokenRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                result.isSuccessful = false
                result.errorMessage = "Error contacting the server. Please Check your internet connection"
                completion(result)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode != 200{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Unauthorized"
                    }
                    
                    print("User is Unauthorized to Revoke the Token")
                }
                else{
                    result.isSuccessful = true
                    KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                    KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                }
                
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func ForgotPassword(emailAddress:String, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let forgotPasswordRequest: ForgotPasswordRequest = ForgotPasswordRequest(email: emailAddress)
        let request = AppUrlRequest(url: apiRoutes.forgotPassword!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(forgotPasswordRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                result.isSuccessful = false
                result.errorMessage = "Error contacting the server. Please Check your internet connection"
                completion(result)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error: Please Enter a Valid Email Address to Request a Reset Token"
                    }
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func Register(firstName: String, lastName: String, email: String, password: String, confirmPassword: String, currency: String, acceptTerms: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let registerRequest: RegisterRequest = RegisterRequest(title: "", firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, currency: currency, acceptTerms: acceptTerms)
        let request = AppUrlRequest(url: apiRoutes.register!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(registerRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                result.isSuccessful = false
                result.errorMessage = "Error contacting the server. Please Check your internet connection"
                completion(result)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error Registering User"
                    }
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func ResetPassword(token:String, newpassword:String, confirmPassword:String, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let resetPasswordRequest = ResetPasswordRequest(token: token, password: newpassword, confirmPassword: confirmPassword)
        let request = AppUrlRequest(url: apiRoutes.resetPassword!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(resetPasswordRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                result.isSuccessful = false
                result.errorMessage = "Error contacting the server. Please Check your internet connection"
                completion(result)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error: Invalid Token or Password. Password Length must be greater than 5 characters and both Passwords should match"
                    }
                    
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func OnBoardCompleted() {
        
        var request = AppUrlRequest(url: apiRoutes.onBoard!, httpMethod: "POST").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let jsonData = try! JSONEncoder().encode("")
            
            let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
                result.data = data
                
                if error != nil || data == nil {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        print("Unauthorized")
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Couldn Not OnBoard User"
                        }
                        
                    }
                }
                
                
            }
            task.resume()
            
            
        }
        
        
    }
    
    func GetWatchList(completion: @escaping (RequestResponse) -> ()) {
        
        var request = AppUrlRequest(url: apiRoutes.watchList!, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 201){
                        result.isSuccessful = true
                        result.data = Data()
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve WatchList"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func SearchStock(textToSearch: String, completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.searchStock!
        let queryItems = [URLQueryItem(name: "stocktosearch", value: textToSearch)]
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 201){
                        result.isSuccessful = true
                        result.data = Data()
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve Stock Information"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func AddStockToWatchList(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.addStock!
        let queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)")]
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "PUT").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Add Stock To Watchliist"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func RemoveStockFromWatchList(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.removeStock!
        let queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)")]
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "DELETE").request
        
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Add Stock To Watchliist"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    
    func GetStockInfo(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.stockInfo!
        let queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)")]
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve Stock Information"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    
    func GetStockHolding(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.stockHolding!
        let queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)")]
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve Stock Information"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func GetPriceChart(stockId: Int, interval: String, isPriceHistory: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url:URL
        
        var queryItems:[URLQueryItem]
        
        if(isPriceHistory){
            url = apiRoutes.priceHistory!
            queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)"), URLQueryItem(name: "interval", value: "\(interval)")]
        }
        else{
            url = apiRoutes.priceChart!
            queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)")]
        }
        
        let newUrl = url.appending(queryItems)!
        
        var request = AppUrlRequest(url: newUrl, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if (httpResponse.statusCode == 200 && data != nil){
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve Stock Information"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func IsMarketOpen(completion: @escaping (RequestResponse) -> ()) {
        
        var request = AppUrlRequest(url: apiRoutes.isMarketOpen!, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 201){
                        result.isSuccessful = true
                        result.data = Data()
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve Market Hours"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func GetWallet(completion: @escaping (RequestResponse) -> ()) {
        
        var request = AppUrlRequest(url: apiRoutes.wallet!, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil  {
                    print("Client error!")
                    print("Error is \(error!)")
                    result.isSuccessful = false
                    result.errorMessage = "Error contacting the server. Please Check your internet connection"
                    completion(result)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 201){
                        result.isSuccessful = true
                        result.data = Data()
                    }
                    else if(httpResponse.statusCode == 401){
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .didAuthTokenExpire, object: nil)
                            print("401 Unauthorized")
                        }
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve User Wallet"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
}
