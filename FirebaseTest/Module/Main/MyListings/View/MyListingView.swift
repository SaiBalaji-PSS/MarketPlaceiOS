//
//  MyListingView.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 27/04/26.
//

import SwiftUI

struct MyListingView: View {
    @StateObject private var myListingVM = MyListingViewModel(service: MyListingFirestoreService())
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack{
            List(myListingVM.myListings,id:\.listingId!){ listing in
               ListingItemCell(listingItem: listing)
                    .swipeActions {
                        Button("Delete"){
                            if let listingId = listing.listingId{
                                Task{
                                    await self.myListingVM.deleteMyListing(listingId: listingId)
                                    await self.myListingVM.getMyListings(userId: self.authVM.getCurrentUserId())
                                }
                            }
                        }
                    }
            }.listStyle(.plain)
            .navigationTitle("My Listings")
            .task{
                Task{
                    await self.myListingVM.getMyListings(userId: self.authVM.getCurrentUserId())
                }
            }
            .overlay {
                if myListingVM.state == .loading{
                    ProgressView()
                        .tint(.green)
                }
            }
            .alert("Info", isPresented: self.$myListingVM.showMessage) {
                Button("OK"){
                            
                }
            } message: {
                Text(self.myListingVM.message)
            }

        }
    }
}

#Preview {
    MyListingView()
}
