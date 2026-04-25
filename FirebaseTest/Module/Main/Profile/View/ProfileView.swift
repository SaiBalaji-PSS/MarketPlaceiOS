//
//  ProfileView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @StateObject private var profileVM = ProfileViewModel(service: ProfileFireStoreService())
    var body: some View {
        NavigationStack{
            VStack{
                ProfileHeaderView(profileVM:profileVM) {
                    //show image picker
                    self.showImagePicker = true
                }
                VStack(alignment:.leading){
                    Text("Stats")
                        .bold()
                    HStack{
                        StatView(titleValue: "Items Sold", subtitleValue: "\(profileVM.userData?.itemsSold ?? 0)")
                        StatView(titleValue: "Total Sales", subtitleValue: "$\(profileVM.userData?.totalSales ?? 0.0)")
                    }
                    
                    HStack{
                        StatView(titleValue: "Items Purchased", subtitleValue: "\(profileVM.userData?.itemsPurchased ?? 0)")
                        StatView(titleValue: "Joining Date", subtitleValue: "\(profileVM.userData?.createdAt.getFormattedCreatedDateString() ?? "")")
                    }
                    
                }.padding()
                Button {
                    self.authVM.signOut()
                } label: {
                    Text("Sign Out")
                        .tint(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                        .padding()
                       
                }

                Spacer()
            }.frame(maxWidth: .infinity,maxHeight: .infinity).background(.profileBG)
                .navigationTitle("Profile")
                .task {
                    Task{
                        await profileVM.getProfileInfo(id: self.authVM.getCurrentUserId())
                    }
                }
                .overlay {
                    if self.profileVM.isLoading{
                        ProgressView()
                            .tint(.yellow)
                            .frame(width: 200, height: 200)
                            .background(Color.lightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .onChange(of: self.selectedImage ?? UIImage()) { oldValue, newValue in
                    print(newValue)
                    Task{
                        if let imageData = newValue.jpegData(compressionQuality: 0.5){
                           await self.profileVM.uploadProfileImage(id: self.authVM.getCurrentUserId(), imageData: imageData)
                        }
                    }
                }
        }

    }
}

#Preview {
    ProfileView()
}

