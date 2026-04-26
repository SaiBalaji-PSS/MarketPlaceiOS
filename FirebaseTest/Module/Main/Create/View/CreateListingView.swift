//
//  CreateListingView.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import SwiftUI
import UIKit

struct CreateListingView: View {
    let listingId = UUID().uuidString
    @State private var productName: String = ""
    @State private var quantity: String = ""
    @State private var price: Double = 0.0
    @Environment(\.locale) var locale
    @EnvironmentObject var authVM: AuthViewModel
    @State private var productImages = [UIImage]()
    @State private var productImageData = [Data]()
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @StateObject private var createListingVM = CreateListingViewModel(service: CreateListingService())
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Product Name"){
                    TextField("", text: $productName)
                }
                Section("Quantity"){
                    TextField("", text: $quantity)
                        .keyboardType(.numberPad)
                }
                Section("Price"){
                    TextField("",value: $price,format: .currency(code: locale.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
                Section("Product Images"){
                    HStack{
                        Spacer()
                        Button("Add Image"){
                            self.showImagePicker = true
                        }
                    }
                    HStack{
                   
                        ScrollView(.horizontal){
                            LazyHStack{
                                ForEach(productImages,id:\.self){ image in
                                    ProductImageCell(image: image) {
                                        self.deleteImage(image)
                                    }
                                }
                             
                            }
                        }

                    }
                }
                
                Section("Pick up Location"){
                    
                }
                
                HStack{
                    Spacer()
                    Button("Save"){
                        Task{
                            await self.uploadListing()
                        }
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImage: $selectedImage)
            })
            .onChange(of: selectedImage ?? UIImage(), { oldValue, newValue in
                self.productImages.append(newValue)
                if let imageData = newValue.jpegData(compressionQuality: 0.5){
                    self.productImageData.append(imageData)
                }
            })
            .alert("Info", isPresented: $createListingVM.shouldShowAlert, actions: {
                Button("OK"){
                    
                }
            }, message: {
                Text(self.createListingVM.message)
            })
            .overlay(content: {
                if self.createListingVM.createListingState == .loading{
                    ProgressView()
                        .tint(.green)
                }
            })
            .navigationTitle("Add Listing")
        }
    }
    
    private func deleteImage(_ image: UIImage) {
        if let index = productImages.firstIndex(of: image) {
            productImages.remove(at: index)
        }
    }
    
    private func uploadListing()async {
        await self.createListingVM.uploadListing(listing: ListingModel(listingId: self.listingId, sellerId: self.authVM.getCurrentUserId(), productName: self.productName, quantity: Int(self.quantity) ?? 0, price: self.price, imageUrls: [], createdDate: Date()),imageData: self.productImageData)
    }
}

#Preview {
    CreateListingView()
        .environmentObject(AuthViewModel(service: FirebaseAuthService()))
}
