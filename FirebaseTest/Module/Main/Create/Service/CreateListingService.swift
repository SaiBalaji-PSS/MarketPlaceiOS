//
//  CreateListingService.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CreateListingService: CreateListingProtocol{
    var collectionName: String = "listings"
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func uploadListing(listing: ListingModel) async throws -> String {
        guard let listingId = listing.listingId else{throw NSError(domain: "Invalid listing id", code: 0)}
        try await db.collection(collectionName)
                                 .document(listingId)
                                 .setData([
                                    "product_name": listing.productName,
                                    "seller_id": listing.sellerId,
                                    "quantity": listing.quantity,
                                    "price": listing.price,
                                    "image_urls": listing.imageUrls,
                                    "created_date": Date()
                                 ])
        return listingId
    }
    
    func uploadImages(imageData: [Data],listingId: String?) async throws -> [String] {
        guard let listingId = listingId else{throw NSError(domain: "Invalid listing id", code: 0)}
        
        var imageBucketUrls = [String]()
        
        let folderName = "listing_images"
        let subFolderName = "\(listingId)"
        for (index,data) in imageData.enumerated(){
            let fileRef = storage.reference().child("\(folderName)/\(subFolderName)/\(index).jpeg")
            let _ = try await fileRef.putDataAsync(data)
            let fileBucketUrl = try await fileRef.downloadURL()
            imageBucketUrls.append(fileBucketUrl.absoluteString)
        }
        return imageBucketUrls
    }
    func deleteListingImages(listingId: String?) async throws {
        guard let listingId = listingId else{throw NSError(domain: "Invalid listing id", code: 0)}
        let subFolderName = "\(listingId)"
        let folderRef = storage.reference()
               .child("listing_images/\(listingId)")
           
           let result = try await folderRef.listAll()
           
           for item in result.items {
               try await item.delete()
           }
        
    }
}
