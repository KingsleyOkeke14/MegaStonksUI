//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct WatchListPageView: View {
    

    let myColors = MyColors()
    @State var searchText:String = ""
    
    @State private var selectedItem: String?
    
    @EnvironmentObject var myAppObjects:AppObjects
    
    
    @State var isEditing: Bool = false
    
    @State var isLoading: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userAuth:UserAuth
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .systemGray4
        
        let color = UIView()
        color.backgroundColor = .systemGray6
        UITableViewCell.appearance().selectedBackgroundView = color
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Image("megastonkslogo")
                    .scaleEffect(0.6)
                    .aspectRatio(contentMode: .fit)
                HStack {
                    TextField("Tap to Start Search", text: $searchText, onCommit: {
                        isLoading = true
                        myAppObjects.SearchStock(stockToSearch: searchText){
                            result in
                            if(result.isSuccessful){
                                
                                DispatchQueue.main.async {
                                    myAppObjects.stockSearchResult = result.stockSearchResponse
                                }
                            }
                        }
                        isLoading = false
                    })
                        .padding()
                        .padding(.horizontal, 24)
                        .background(myColors.grayColor)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .cornerRadius(20)
                        
                        
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(myColors.lightGrayColor)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 12)
                            }
                            
                        )
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.searchText = ""
                            myAppObjects.SearchStockAsync()
                            isLoading = false
                            hideKeyboard()
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Text("Cancel")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }.padding(.horizontal).padding(.vertical, 2)
                
                if(isEditing){
                    VStack{
                        HStack{
                            Text("Stocks")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        
                        if(!myAppObjects.stockSearchResult.isEmpty){
                                ScrollView{
                                    ForEach(myAppObjects.stockSearchResult, id: \.self){ stock in
                                        NavigationLink(
                                            destination: StocksInfoPageView(stock: StockSymbolModel().symbols[0]),
                                            tag: stock.id.uuidString,
                                            selection: $selectedItem,
                                            label: {StockSearchView(stock: stock)})
                                        
                                    }
                                    .padding()
                                    
                                    
                                }.overlay(
                                    VStack{
                                        if(isLoading){
                                        ProgressView()
                                                .accentColor(.green)
                                                .scaleEffect(x: 1.4, y: 1.4)
                                        .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                        }
                                })

                            }
                        else{
                            Spacer()
                            Text("Could not find what you were looking for? Please remember that we only provide access to the US and Canadian stock market at this time. Please contact us if you have any further questions")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                            
                        
                        Spacer()
                    }.frame(height: 300)
                }
                HStack{
                    Text("Watchlist")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(myColors.greenColor)
                    Image(systemName: "eye")
                        .foregroundColor(myColors.greenColor)
                        .font(.custom("", fixedSize: 18))
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                if(!myAppObjects.watchList.isEmpty){
                        ScrollView{
                            ForEach(myAppObjects.watchList, id: \.self){ stock in
                                
                                NavigationLink(
                                    destination: StocksInfoPageView(stock: stock).onDisappear(perform: {
                                        myAppObjects.updateWatchListAsync()
                                    }),
                                    tag: stock.id.uuidString,
                                    selection: $selectedItem,
                                    label: {StockSymbolView(stock: stock)})
                                
                            }
                            .padding()
                            
                            
                        }
                    
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }.onAppear(perform: {
            
            myAppObjects.updateWatchListAsync()
        })
        .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct WatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListPageView()
            .environmentObject(AppObjects())
            .preferredColorScheme(.dark)
        
        
    }
}
