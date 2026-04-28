//
//  MainTabbar.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct MainTabbar: View {
   
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Sell",systemImage: "bag"){
                CreateListingView()
            }
            Tab("My Listings",systemImage: "shippingbox"){
                MyListingView()
            }
            Tab("Profile",systemImage: "person"){
               ProfileView()
            }
        }
    }
}

#Preview {
    MainTabbar()
}
