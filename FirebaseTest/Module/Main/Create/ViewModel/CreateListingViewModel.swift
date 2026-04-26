//
//  CreateListingViewModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import Foundation
import Combine

@MainActor
class CreateListingViewModel: ObservableObject{
    
    enum CreateListingState{
        case loading
        case uploadSuccess
        case uploadFailed
        case idle
    }
    
    
    private var service: CreateListingService
    @Published var createListingState: CreateListingState = .idle
    @Published var shouldShowAlert: Bool = false
    @Published var message: String = ""
    
    init(service: CreateListingService) {
        self.service = service
    }
    
    func uploadListing(listing: ListingModel,imageData:[Data])async{
        
        
        defer{
            self.createListingState = .idle
        }
        self.createListingState = .loading
        var listingModel = listing
        do{
            //Uplaod images to bucket and get the url
            let imageUrls = try await self.service.uploadImages(imageData: imageData, listingId: listingModel.listingId)
            listingModel.imageUrls = imageUrls
            //Upload the product data along with images
            print("SERVICE RECEIVED URLS:", listingModel.imageUrls)
            let listingId = try await self.service.uploadListing(listing: listingModel)
            self.createListingState = .uploadSuccess
            self.message = "Listing Uploaded Succesfully"
            self.shouldShowAlert = true
        }
        catch{
            print(error)
            self.createListingState = .uploadFailed
            self.message = error.localizedDescription
            self.shouldShowAlert = true
            //delete listing images if product upload failed
            if let _ = try? await  self.service.deleteListingImages(listingId: listingModel.listingId){
                
            }
        }
    }
    
    
    
}
