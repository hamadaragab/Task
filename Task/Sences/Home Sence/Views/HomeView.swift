//
//  HomeView.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ZStack{
                Color("backGround").ignoresSafeArea()
                ActivityIndicator(isAnimating: .constant( viewModel.isloading), style: .large)
                Text(viewModel.error).font(.system(size: 28,weight: .bold)).foregroundColor(.red)
                VStack(alignment: .leading) {
                    AppBarView()
                    ScrollView(.vertical,showsIndicators: false) {
                        HStack {
                            tagLineView().padding(.leading,20)
                            Spacer()
                        }
                        ScrollView(.vertical,showsIndicators: false) {
                            VStack {
                                ForEach(viewModel.products,id: \.uid) { productData in
                                    NavigationLink(destination: DetailsView(productData: productData,urlString: productData.image_urls?.first ?? "")) {
                                        ProductView(viewsize: (UIScreen.main.bounds.width - 50), product: productData)
                                    }.foregroundColor(.black)
                                }.padding(.trailing)
                            }
                        }.padding(.leading)
                    }
                }
            }
            
        }.onAppear{
            viewModel.getItems()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct AppBarView: View {
    var body: some View {
        HStack {
            Button {} label: {
                Image("menu").padding().cornerRadius(10)
            }
            Spacer()
            Button {} label: {
                Image("Profile").resizable().frame(width: 42,height: 42).cornerRadius(10)
            }
            
        }.padding()
    }
}

struct tagLineView: View {
    var body: some View {
        Text("Finsd the \nbest ").font(.system(size: 28,weight: .regular)).foregroundColor(.primary) +
        Text("Items").font(.system(size: 28,weight: .bold)).foregroundColor(.primary)
    }
}
struct  ProductView: View {
    let viewsize: CGFloat
    let product: Results
    @ObservedObject var imageDownloader: ImageDownloader
    init(viewsize: CGFloat,product: Results) {
        imageDownloader = ImageDownloader(urlString: product.image_urls?.first ?? "")
        self.viewsize = viewsize
        self.product = product
    }
    var body: some View {
        VStack {
            Image(uiImage: imageDownloader.image ?? UIImage(named: "placeHolder")!)
                .resizable()
                .cornerRadius(20).frame(width: viewsize,height: 200 ).aspectRatio(contentMode: .fit)
            HStack(spacing: 2){
                Text(product.name ?? "").font(.title3).multilineTextAlignment(.leading)
                Spacer()
                Text(product.price ?? "").font(.title3).fontWeight(.bold)
            }
        }.frame(width: viewsize).padding().background(Color.white).cornerRadius(20)
        
    }
}


