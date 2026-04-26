//
//  CreateListingView.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import SwiftUI
import UIKit

struct CreateListingView: View {
    enum Field: CaseIterable{
        case productName
        case description
        case quantity
        case price
    }
    
    let listingId = UUID().uuidString
    @Environment(\.locale) var locale
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showImagePicker: Bool = false
    @StateObject private var createListingVM = CreateListingViewModel(service: CreateListingService())
    @FocusState private var selectedField: Field?
    @State private var fields = Field.allCases
    @State private var currentFieldIndex = 0
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Product Name"){
                    TextField("", text: $createListingVM.productName)
                        .focused($selectedField, equals: Field.productName)
                }
                Section("Product Description"){
                    TextField("", text: $createListingVM.productDescription)
                        .frame(height:200)
                        .focused($selectedField, equals: Field.description)
                }
                Section("Quantity"){
                    TextField("", text: $createListingVM.quantity)
                        .keyboardType(.numberPad)
                        .focused($selectedField, equals: Field.quantity)
                }
                Section("Price"){
                    TextField("",value:  $createListingVM.price,format: .currency(code: locale.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($selectedField, equals: Field.price)
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
                                ForEach(createListingVM.productImages.indices, id: \.self) { index in
                                    let image = createListingVM.productImages[index]
                                    
                                    ProductImageCell(image: image) {
                                        self.deleteImage(image)
                                    }
                                }
                             
                            }
                        }

                    }
                }
                
                Section("Category"){
                    Picker("Category", selection: $createListingVM.selectedCategory) {
                        ForEach(createListingVM.category,id:\.self){ category in
                            Text(category)
                        }
                    }
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                      Button("Up") {
                          currentFieldIndex = (currentFieldIndex + 1) % fields.count
                          selectedField = fields[currentFieldIndex]
                      }

                      Button("Down") {
                          currentFieldIndex = max(0, currentFieldIndex - 1)
                          selectedField = fields[currentFieldIndex]
                      }

                      Spacer()

                      Button("Done") {
                          selectedField = nil
                      }
                  }
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImage:  $createListingVM.selectedImage)
            })
            .onChange(of: createListingVM.selectedImage) { oldValue, newValue in
                guard let newValue = newValue else { return }

                createListingVM.productImages.append(newValue)

                if let imageData = newValue.jpegData(compressionQuality: 0.5) {
                    createListingVM.productImageData.append(imageData)
                }
            }
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
            .onAppear(perform: {
                
            })
            .navigationTitle("Add Listing")
        }
    }
    
    private func deleteImage(_ image: UIImage) {
        if let index = self.createListingVM.productImages.firstIndex(of: image) {
            self.createListingVM.productImages.remove(at: index)
        }
    }
    
    private func uploadListing()async {
        await self.createListingVM.uploadListing(listing: ListingModel(listingId: self.listingId, sellerId: self.authVM.getCurrentUserId(), productName: self.createListingVM.productName,productDescription: self.createListingVM.productDescription, quantity: Int(self.createListingVM.quantity) ?? 0, price: self.createListingVM.price, imageUrls: [], category: self.createListingVM.selectedCategory, createdDate: Date()),imageData: self.createListingVM.productImageData)
    }
}

#Preview {
    CreateListingView()
        .environmentObject(AuthViewModel(service: FirebaseAuthService()))
}
