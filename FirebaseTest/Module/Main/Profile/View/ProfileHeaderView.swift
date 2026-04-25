//
//  ProfileHeaderView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var profileVM: ProfileViewModel
    @State private var showImage: Bool = false
    var imageTapped: (() -> (Void))?
    
    var body: some View {
        HStack{
            if let profileImageUrl = profileVM.userData?.profileImageUrl, profileImageUrl.isEmpty == false{
                AsyncImage(url: URL(string: profileImageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .onTapGesture {
                            imageTapped?()
                        }
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
            }
            else{
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40,height: 40)
                    .padding()
                    .background(.gray)
                    .clipShape(Circle())
                    .onTapGesture {
                        imageTapped?()
                    }
            }
            
            VStack(alignment:.leading,spacing: 18){
                Text(profileVM.userData?.userName ?? "")
                    .bold()
                Text(profileVM.userData?.email ?? "")
            }
            Spacer()
            
            
        }.frame(maxWidth: .infinity).padding().background(.white).clipShape(RoundedRectangle(cornerRadius: 18.0)).padding(.horizontal)
    }
}
