//
//  NewsPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-10.
//

import SwiftUI

struct NewsPageView: View {
    
    
    let myColors = MyColors()
    
    @State private var currentPage: Int = 0
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
                       PageView(pages: [NewsPage(isLoadingNews: $isLoadingNews)], currentPage: $currentPage)
                    }
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
        NewsPageView()
        .environmentObject(AppObjects())
            .preferredColorScheme(.dark)
    }
}
