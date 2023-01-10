//
//  DetailsView.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var imageDownloader: ImageDownloader
    var productData: Results?
    init(productData: Results?,urlString: String?) {
        imageDownloader = ImageDownloader(urlString: urlString)
        self.productData = productData
    }
    var body: some View {
        ZStack {
            Color("backGround").ignoresSafeArea(.all)
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading) {
                    Image(uiImage: imageDownloader.image ?? UIImage(named: "placeHolder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    DescriptionView(productName: productData?.name ?? "").offset(y: -40)
                }
            }.edgesIgnoringSafeArea(.all)
            AddToCartView(productPrice: productData?.price ?? "").frame(maxHeight: .infinity,alignment: .bottom)
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward").padding(.all,12).background(Color.white).cornerRadius(8.0).foregroundColor(.black)
        }),trailing: Image("threeDot"))
    }
}
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(productData: nil, urlString: nil)
    }
}


struct DescriptionView: View {
    let productName: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(productName).font(.title3).fontWeight(.bold)
                Text("Description").fontWeight(.semibold).padding(.vertical,8)
            }
            Spacer()
        }.padding().padding(.top).background(Color("backGround")).cornerRadius(40)
            
    }
}

struct AddToCartView: View {
    let productPrice: String
    var body: some View {
        HStack {
            Text(productPrice).font(.title).fontWeight(.medium).foregroundColor(.white)
            Spacer()
            Button {
            } label: {
                Text("Add To Cart ").padding().padding(.horizontal).background(Color.white).cornerRadius(10).foregroundColor(Color("MainColor"))
            }
            
        }.padding().padding(.horizontal).background(Color("MainColor")).cornerRadius(50,corners: .topLeft)
    }
}
