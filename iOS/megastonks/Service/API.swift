//
//  API.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-28.
//

import Foundation
import SwiftKeychainWrapper

struct APIRoutes {
    let server:String
    #if DEBUG
    let domain = "megastonksdev.azurewebsites.net"
    #else
    let domain = "megastonksprod.azurewebsites.net"
    #endif
    private let authRoute = "accounts/authenticate"
    private let registerRoute = "accounts/register"
    private let stockWatchlistRoute = "watchlist/getwatchlist"
    private let cryptoWatchlistRoute = "watchlist/getCryptoWatchList"
    private let revokeTokenRoute = "accounts/revoke-token"
    private let refreshTokenRoute = "accounts/refresh-token"
    private let forgotPasswordRoute = "accounts/forgot-password"
    private let resetPasswordRoute = "accounts/reset-password"
    private let onBoardRoute = "accounts/onboard-completed"
    private let searchStockRoute = "stocks/searchstock"
    private let searchCryptoRoute = "cryptos/searchCrypto"
    private let getCryptoInSchemaRoute = "cryptos/cryptosInSchema"
    private let addStockRoute = "watchlist/addstock"
    private let removeStockRoute = "watchlist/removestock"
    private let addCryptoRoute = "watchlist/addCrypto"
    private let removeCryptoRoute = "watchlist/removeCrypto"
    private let stockInfoRoute = "stocks/stockinfo"
    private let cryptoInfoRoute = "cryptos/crypto"
    private let stockHoldingRoute = "stocks/stockholding"
    private let stockHoldingsRoute = "stocks/stockholdings"
    private let cryptoHoldingRoute = "cryptos/cryptoholding"
    private let cryptoHoldingsRoute = "cryptos/cryptoholdings"
    private let stockPriceChartRoute = "stocks/pricechart"
    private let stockPriceHistoryRoute = "stocks/pricehistory"
    private let cryptoPriceChartRoute = "cryptos/pricechart"
    private let cryptoPriceHistoryRoute = "cryptos/pricehistory"
    private let isMarketOpenRoute = "fmpApi/ismarketopen"
    private let walletRoute = "wallet"
    private let orderStockHistoryRoute = "order/getorders"
    private let orderCryptoHistoryRoute = "order/getcryptoorders"
    private let orderStockRoute = "order/orderStock"
    private let orderCryptoRoute = "order/orderCrypto"
    private let getAdsRoute = "ads/getallads"
    private let getNewsRoute = "stocks/stocknews"
    
    
    var auth = URL(string: "")
    var register = URL(string: "")
    var stockWatchList = URL(string: "")
    var cryptoWatchList = URL(string: "")
    var revokeToken = URL(string: "")
    var refreshToken = URL(string: "")
    var forgotPassword = URL(string: "")
    var resetPassword = URL(string: "")
    var onBoard = URL(string: "")
    var searchStock = URL(string: "")
    var searchCrypto = URL(string: "")
    var getCryptoInSchema = URL(string: "")
    var addStock = URL(string: "")
    var removeStock = URL(string: "")
    var addCrypto = URL(string: "")
    var removeCrypto = URL(string: "")
    var stockInfo = URL(string: "")
    var cryptoInfo = URL(string: "")
    var stockHolding = URL(string: "")
    var stockHoldings = URL(string: "")
    var cryptoHolding = URL(string: "")
    var cryptoHoldings = URL(string: "")
    var stockPriceChart = URL(string: "")
    var stockPriceHistory = URL(string: "")
    var cryptoPriceChart = URL(string: "")
    var cryptoPriceHistory = URL(string: "")
    var isMarketOpen = URL(string: "")
    var wallet = URL(string: "")
    var orderStockHistory = URL(string: "")
    var orderCryptoHistory = URL(string: "")
    var orderStock = URL(string: "")
    var orderCrypto = URL(string: "")
    var getAds = URL(string: "")
    var getNews = URL(string: "")
    
    init() {
        server = "https://\(domain)/"
        auth = URL(string: server + authRoute)!
        register = URL(string: server + registerRoute)!
        stockWatchList = URL(string: server + stockWatchlistRoute)!
        cryptoWatchList = URL(string: server + cryptoWatchlistRoute)!
        revokeToken = URL(string: server + revokeTokenRoute)!
        refreshToken = URL(string: server + refreshTokenRoute)!
        forgotPassword = URL(string: server + forgotPasswordRoute)!
        resetPassword = URL(string: server + resetPasswordRoute)!
        onBoard = URL(string: server + onBoardRoute)!
        searchStock = URL(string: server + searchStockRoute)!
        searchCrypto = URL(string: server + searchCryptoRoute)!
        getCryptoInSchema = URL(string: server + getCryptoInSchemaRoute)!
        addStock = URL(string: server + addStockRoute)!
        removeStock = URL(string: server + removeStockRoute)!
        addCrypto = URL(string: server + addCryptoRoute)!
        removeCrypto = URL(string: server + removeCryptoRoute)!
        stockInfo = URL(string: server + stockInfoRoute)!
        cryptoInfo = URL(string: server + cryptoInfoRoute)!
        stockHolding = URL(string: server + stockHoldingRoute)!
        stockHoldings = URL(string: server + stockHoldingsRoute)!
        cryptoHolding = URL(string: server + cryptoHoldingRoute)!
        cryptoHoldings = URL(string: server + cryptoHoldingsRoute)!
        stockPriceChart = URL(string: server + stockPriceChartRoute)!
        stockPriceHistory = URL(string: server + stockPriceHistoryRoute)!
        cryptoPriceChart = URL(string: server + cryptoPriceChartRoute)!
        cryptoPriceHistory = URL(string: server + cryptoPriceHistoryRoute)!
        isMarketOpen = URL(string: server + isMarketOpenRoute)!
        wallet = URL(string: server + walletRoute)!
        orderStockHistory = URL(string: server + orderStockHistoryRoute)!
        orderCryptoHistory = URL(string: server + orderCryptoHistoryRoute)!
        orderStock = URL(string: server + orderStockRoute)!
        orderCrypto = URL(string: server + orderCryptoRoute)!
        getAds = URL(string: server + getAdsRoute)!
        getNews = URL(string: server + getNewsRoute)!
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
                    KeychainWrapper.standard.set(jsonResponse.email, forKey: "EmailAddress")
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
                    KeychainWrapper.standard.removeObject(forKey: "EmailAddress")
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
    
    func GetAssetWatchList(isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var request = AppUrlRequest(url: apiRoutes.stockWatchList!, httpMethod: "GET").request
        
        if(isCrypto){
            request = AppUrlRequest(url: apiRoutes.cryptoWatchList!, httpMethod: "GET").request
        }
        
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
    
    func SearchAsset(isCrypto: Bool, textToSearch: String, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.searchStock!
        var queryItems = [URLQueryItem(name: "stocktosearch", value: textToSearch)]
        var newUrl = url.appending(queryItems)!
        
        if(isCrypto){
            url = apiRoutes.searchCrypto!
            queryItems = [URLQueryItem(name: "cryptoToSearch", value: textToSearch)]
            newUrl = url.appending(queryItems)!
        }
        
        
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
    
    func GetCryptoInSchema(completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.getCryptoInSchema!
        
        var request = AppUrlRequest(url: url, httpMethod: "GET").request
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
    
    
    func AddAssetToWatchList(assetId: Int, isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.addStock!
        var queryItems = [URLQueryItem(name: "stockId", value: "\(assetId)")]
        var newUrl = url.appending(queryItems)!
        
        if(isCrypto){
            url = apiRoutes.addCrypto!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(assetId)")]
            newUrl = url.appending(queryItems)!
        }
        
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
                            result.errorMessage = "Could Not Add Asset To Watchliist"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func RemoveAssetFromWatchList(assetId: Int, isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.removeStock!
        var queryItems = [URLQueryItem(name: "stockId", value: "\(assetId)")]
        var newUrl = url.appending(queryItems)!
        
        if(isCrypto){
            url = apiRoutes.removeCrypto!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(assetId)")]
            newUrl = url.appending(queryItems)!
        }
        
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
    
    
    func GetAssetInfo(assetId: Int, isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.stockInfo!
        var queryItems = [URLQueryItem(name: "stockId", value: "\(assetId)")]
        var newUrl = url.appending(queryItems)!
        
        if(isCrypto){
            url = apiRoutes.cryptoInfo!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(assetId)")]
            newUrl = url.appending(queryItems)!
        }
        
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
    
    
    func GetAssetHolding(assetId: Int, isCrypto:Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.stockHolding!
        var queryItems = [URLQueryItem(name: "stockId", value: "\(assetId)")]
        var newUrl = url.appending(queryItems)!
        
        if(isCrypto){
            url = apiRoutes.cryptoHolding!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(assetId)")]
            newUrl = url.appending(queryItems)!
        }
        
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
    
    func GetAssetHoldings(isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url = apiRoutes.stockHoldings!
        if isCrypto {
            url = apiRoutes.cryptoHoldings!
        }
        var request = AppUrlRequest(url: url, httpMethod: "GET").request
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
                    
                    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 200){
                        
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
                            result.errorMessage = "Could Not Retrieve Asset Holdings"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func GetStockPriceChart(stockId: Int, interval: String, isPriceHistory: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url:URL
        
        var queryItems:[URLQueryItem]
        
        if(isPriceHistory){
            url = apiRoutes.stockPriceHistory!
            queryItems = [URLQueryItem(name: "stockId", value: "\(stockId)"), URLQueryItem(name: "interval", value: "\(interval)")]
        }
        else{
            url = apiRoutes.stockPriceChart!
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
    
    func GetCryptoPriceChart(cryptoId: Int, isPriceHistory: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url:URL
        
        var queryItems:[URLQueryItem]
        
        if(isPriceHistory){
            url = apiRoutes.cryptoPriceHistory!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(cryptoId)")]
        }
        else{
            url = apiRoutes.cryptoPriceChart!
            queryItems = [URLQueryItem(name: "cryptoId", value: "\(cryptoId)")]
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
    
    func GetOrderHistory(isCrypto: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var url: URL = apiRoutes.orderStockHistory!
        
        if(isCrypto){
            url = apiRoutes.orderCryptoHistory!
        }
        
        var request = AppUrlRequest(url: url, httpMethod: "GET").request
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
                    
                    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201){
                        
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
                            result.errorMessage = "Could Not Retrieve Asset Information"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func OrderStock(stockId:Int, orderType:String, orderAction:String, quantitySubmitted: Int, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let orderStockRequest = OrderStockRequest(stockId: stockId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted)
        var request = AppUrlRequest(url: apiRoutes.orderStock!, httpMethod: "POST").request
        
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            
            let jsonData = try! JSONEncoder().encode(orderStockRequest)
            
            
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
                            result.errorMessage = "Error: Placing Order. Please try again or contact us if the porblem persists"
                        }
                    }
                }
                completion(result)
                
            }
            task.resume()
        }
    }
    
    func OrderCrypto(cryptoId:Int, orderType:String, orderAction:String, quantitySubmitted: Double, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let orderCryptoRequest = OrderCryptoRequest(cryptoId: cryptoId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted)
        var request = AppUrlRequest(url: apiRoutes.orderCrypto!, httpMethod: "POST").request
        
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            
            let jsonData = try! JSONEncoder().encode(orderCryptoRequest)
            
            
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
                            result.errorMessage = "Error: Placing Order. Please try again or contact us if the porblem persists"
                        }
                    }
                }
                completion(result)
                
            }
            task.resume()
        }
    }
    
    func GetAds(completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.getAds!
        
        var request = AppUrlRequest(url: url, httpMethod: "GET").request
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
                    
                    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201){
                        
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
                            result.errorMessage = "Could Not Ads"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
    
    func GetNews(completion: @escaping (RequestResponse) -> ()) {
        
        let url = apiRoutes.getNews!
        
        var request = AppUrlRequest(url: url, httpMethod: "GET").request
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
                    
                    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201){
                        
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
                            result.errorMessage = "Could Not News"
                        }
                        
                    }
                }
                completion(result)
            }
            task.resume()
            
            
        }
        
        
    }
}
