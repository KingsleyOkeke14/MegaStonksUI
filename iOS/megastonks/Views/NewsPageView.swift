//
//  NewsPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-10.
//

import SwiftUI

struct NewsPageView: View {
    
    
    let myColors = MyColors()
    
    @State private var selectedItem: String?
    @State var isLoadingNews: Bool = false
    @EnvironmentObject var myAppObjects:AppObjects
    
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
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack {
                        HStack{
                            Text("News Feed")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .padding(.horizontal)
                            Spacer()
                        }
                        VStack(spacing: 12){
                            HStack{
                                Spacer()
                                Button(action: {
                                    isLoadingNews = true
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    
                                    myAppObjects.getNews(){ result in
                                        if(result.isSuccessful){
                                                DispatchQueue.main.async {
                                                    myAppObjects.news = result.newsResponse!
                                                }
                                            isLoadingNews = false
                                        }
                                        else{
                                            isLoadingNews = false
                                        }
                                    }
                                    
                                }, label: {
                                    Text("Refresh Feed")
                                        .font(.custom("Marker Felt", fixedSize: 14))
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(myColors.lightGrayColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                    
                                }).padding(.horizontal)
                            }
                            
                            if(!myAppObjects.news.isEmpty){
                                ScrollView{
                                    VStack(spacing: 0) {
                                        PullToRefreshView(onRefresh:{
                                            isLoadingNews = true
                                            myAppObjects.getNews(){
                                                result in
                                                if(result.isSuccessful){
                                                    DispatchQueue.main.async {
                                                        myAppObjects.news = result.newsResponse!
                                                    }
                                                     isLoadingNews = false
                                                }
                                                else{
                                                    //Would need to show error message here or something
                                                    isLoadingNews = false
                                                }
                                            }
                                        })
                                    }
                                    LazyVStack {
                                        ForEach(myAppObjects.news, id: \.self){ news in
                                            NavigationLink(
                                                destination: NewsView(newsElement: news),
                                                tag: news.id.uuidString,
                                                selection: $selectedItem,
                                                label: {NewsSymbolView(newsElement: news)})

                                        }
                                    }.padding(.horizontal)
                                }

                            }
                            else if(myAppObjects.news.isEmpty && !isLoadingNews){
                               Spacer()
                                VStack(spacing: 16){
                                        Text("The News Feed Cannot be Updated at this Time")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                            .bold()
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                    }
                                Spacer()
                            }
                            Spacer()
                            AdsView(showRandomAd: false).environmentObject(myAppObjects)
                        
                        }.overlay(
                            VStack{
                                if(isLoadingNews){
                                    Color.black
                                        .overlay(
                                            VStack(spacing: 20){
                                                ProgressView()
                                                    .accentColor(.green)
                                                    .scaleEffect(x: 1.4, y: 1.4)
                                                    .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                                Text("Please wait. During peak hours, this process could take up to 30 seconds")
                                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                                    .bold()
                                                    .foregroundColor(.gray)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.horizontal)
                                            }
                                        
                                            
                                        )

                                }
                            }
                    )
                    }
                    
                )
                .onAppear(perform: {
                    if(myAppObjects.news.isEmpty){
                        isLoadingNews = true
                        myAppObjects.getNews(){ result in
                            if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        myAppObjects.news = result.newsResponse!
                                    }
                                isLoadingNews = false
                            }
                            else{
                                isLoadingNews = false
                            }
                        }
                    }
                })
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct NewsPageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView().environmentObject(AppObjects())
    }
}
