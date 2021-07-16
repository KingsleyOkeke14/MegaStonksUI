//
//  NewsPage.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-04.
//

import SwiftUI

struct NewsPage: View {
    
    
    let myColors = MyColors()
    
    @State private var selectedItem: String?
    @Binding var isLoadingNews: Bool
    
    @EnvironmentObject var newsVM: NewsVM
    @EnvironmentObject var adsVM: AdsVM
    
    var body: some View {
        VStack(spacing: 12){
            HStack{
                Spacer()
                Button(action: {
                    isLoadingNews = true
                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                    
                    newsVM.getNews(){ result in
                        if(result.isSuccessful){
                                DispatchQueue.main.async {
                                    newsVM.news = result.newsResponse!
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
            
            
                ScrollView{
                    VStack(spacing: 0) {
                        PullToRefreshView(onRefresh:{
                            isLoadingNews = true
                            newsVM.getNews(){
                                result in
                                if(result.isSuccessful){
                                    DispatchQueue.main.async {
                                        newsVM.news = result.newsResponse!
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
                    if(!newsVM.news.isEmpty){
                    LazyVStack {
                        ForEach(newsVM.news, id: \.self){ news in
                            NavigationLink(
                                destination: NewsInfoView(newsElement: news),
                                tag: news.id.uuidString,
                                selection: $selectedItem,
                                label: {NewsSymbolView(newsElement: news)})

                        }
                    }.padding(.horizontal)
                    }
                    else if(newsVM.news.isEmpty && !isLoadingNews){
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
                }
            AdsView(showRandomAd: false).environmentObject(adsVM)

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
}

struct NewsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsPage(isLoadingNews: Binding.constant(false))
            .preferredColorScheme(.dark)
            .environmentObject(NewsVM())
            .environmentObject(AdsVM())
    }
}
