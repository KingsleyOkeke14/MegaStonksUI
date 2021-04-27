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
    
    @EnvironmentObject var watchListObject:WatchListObject
    
    @State var stocksToSearch:[StockSymbol] = [StockSymbol]()
    
    
    @State var isEditing = false
    
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
                    TextField("Tap to Start Search", text: $searchText)
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
                        
                            if(!stocksToSearch.isEmpty){
                                ScrollView{
                                    ForEach(stocksToSearch, id: \.self){ stock in
                                        NavigationLink(
                                            destination: StocksInfoPageView(stock: stock),
                                            tag: stock.id.uuidString,
                                            selection: $selectedItem,
                                            label: {StockSymbolView(stock: stock)})
                                        
                                    }
                                    .padding()
                                    
                                    
                                }
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
                
                if(!watchListObject.watchList.isEmpty){
                        ScrollView{
                            ForEach(watchListObject.watchList, id: \.self){ stock in
                                
                                NavigationLink(
                                    destination: StocksInfoPageView(stock: stock).onDisappear(perform: {
                                        watchListObject.updateWatchListAsync()
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
            
            watchListObject.updateWatchListAsync()
        })
        .banner(data: $watchListObject.bannerData, show: $watchListObject.showBanner)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct WatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListPageView()
            .environmentObject(WatchListObject())
            .preferredColorScheme(.dark)
        
        
    }
}
