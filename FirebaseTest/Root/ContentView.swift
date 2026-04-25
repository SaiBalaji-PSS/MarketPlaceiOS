//
//  ContentView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authVM = AuthViewModel(service: FirebaseAuthService())
    var body: some View {
        Group{
            switch authVM.authState {
            case .loading:
                ProgressView()
            case .authenticated:
                MainTabbar()
                    .environmentObject(authVM)
            case .unauthenticated:
                LoginView()
                    .environmentObject(authVM)
            }
        }.task {
            self.authVM.getCurrentUserId()
        }
       
    }
}

#Preview {
    ContentView()
}
