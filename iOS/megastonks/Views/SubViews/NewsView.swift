//
//  SafariView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-09.
//

import SwiftUI
import SafariServices

struct NewsView: View {
    
    let myColors = MyColors()
    @EnvironmentObject var myAppObjects:AppObjects
    
    @State var showSafari:Bool = false
    @State var adToShow:Int = 0
    
    var newsElement:NewsElement
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: newsElement.image)!,
                          placeholder: { Image("blackImage") },
                          image: { Image(uiImage: $0).resizable() })
            
                .frame(height: 240, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 8)
                .opacity(0.6)
            
            HStack {
                Text(newsElement.site)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }.padding(.horizontal)
            
            HStack{
                Text(newsElement.symbol)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                    .bold()
                    .foregroundColor(myColors.greenColor)
                    .lineLimit(1)
                Spacer()
            }.padding(.horizontal)
            ScrollView{
                Text(newsElement.text)
                    .font(.custom("Helvetica", fixedSize: 16))
                    .foregroundColor(.white)
                Spacer(minLength: 40)
                Button(action: {
                    showSafari.toggle()
                    
                }, label: {
                    Text("Read More")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: Color.green, radius: 6, x: 2, y: 2)
                })
            }.padding(.horizontal)
            Spacer()
            AdsView(showRandomAd: true).environmentObject(myAppObjects)
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url:URL(string: self.newsElement.url)!)
        }
       
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(newsElement: StockSymbolModel().newsModel).preferredColorScheme(.dark).environmentObject(AppObjects())
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
