//
//  HomeView.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 28/04/26.
//

import Foundation
import SwiftUI


struct HomeView: View{
    @StateObject private var vm = HomeViewModel(service: HomeService())
    @EnvironmentObject var authVM: AuthViewModel
    var columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View{
        NavigationStack {
            ScrollView {
                LazyVStack{
                    ForEach(vm.listings,id:\.listingId!){ listing in
                        ListingItemCell(listingItem: listing)
                    }
                }.padding(.horizontal)
            }
           
            .task {
                Task{
                    await self.vm.getAllListings(currentUserId: authVM.getCurrentUserId())
                }
            }
            .navigationTitle("Listings")
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(AuthViewModel(service: FirebaseAuthService()))
}
