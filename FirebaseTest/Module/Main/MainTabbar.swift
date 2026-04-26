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
                Text("Home")
            }
            Tab("Sell",systemImage: "bag"){
                CreateListingView()
            }
            Tab("Notifications",systemImage: "heart"){
                Text("Notification")
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
