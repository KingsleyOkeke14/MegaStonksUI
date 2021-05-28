//
//  PageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-27.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @Binding var currentPage: Int

    var body: some View {
            ZStack(alignment: .bottom){
                PageViewController(pages: pages, currentPage: $currentPage)
            }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PageView(pages: [AssetWatchListPage(isCrypto: false), AssetWatchListPage(isCrypto: true)], currentPage: Binding.constant(0)).environmentObject(AppObjects()).preferredColorScheme(.dark)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
