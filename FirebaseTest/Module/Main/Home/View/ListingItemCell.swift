//
//  ListingItemCell.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 28/04/26.
//

import SwiftUI

struct ListingItemCell: View {
    let listingItem: ListingModel
    @Environment(\.locale) var locale
    var body: some View {
        VStack{
            HStack(spacing:18){
                if let url = listingItem.imageUrls.first{
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80,height: 80)
                    } placeholder: {
                        ProgressView()
                            //.resizable()
                           // .aspectRatio(contentMode: .fill)
                            .frame(width: 80,height: 80)
                    }

                }
                else{
                    Image(.firebase)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80,height: 80)
                }
                
                   
                      VStack(alignment:.leading,spacing:8){
                          Text(listingItem.productName)
                              .bold()
                          Text("Qty: \(listingItem.quantity)")
                          Text("\(listingItem.category)")
                              .padding(4)
                              .padding(.horizontal,4)
                              .background(.green)
                              .clipShape(Capsule())
                          Divider()
                              .background(.black)
                          Text(listingItem.price,format: .currency(code: locale.currency?.identifier ?? "USD"))
                              .bold()
                          
                      }
            }
         
      
        }.padding().background(.lightGray).clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    ListingItemCell(listingItem:   ListingModel(
        listingId: "listing_003",
        sellerId: "user_123",
        productName: "Men's Running Shoes",
        productDescription: "Size 9, barely used. Comfortable for daily runs.",
        quantity: 3,
        price: 1200.0,
        imageUrls: [
            "https://example.com/images/shoes_1.jpg",
            "https://example.com/images/shoes_2.jpg"
        ],
        category: "Fashion",
        createdDate: Date().addingTimeInterval(-172800) // 2 days ago
    ))
}
