//
//  MyListingFirestoreService.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 27/04/26.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class MyListingFirestoreService: MyListingProtocol{
    var collectionName: String = "listings"
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func fetchMyListings(userId: String)async throws -> [ListingModel] {
        let snapshot =  try await db.collection(collectionName).whereField("seller_id", isEqualTo: userId).getDocuments()
        let listings = snapshot.documents.compactMap { doc in
            do{
               return  try doc.data(as: ListingModel.self)
            }
            catch{
                print(error)
            }
            return nil 
        }
        return listings
    }
    
    func deleteMyListing(listingId: String)async throws {
        try await db.collection(collectionName).document(listingId).delete()
    }
    
    func deleteListingImages(listingId: String?) async throws {
        guard let listingId = listingId else{throw NSError(domain: "Invalid listing id", code: 0)}
        
        let items = try await storage.reference().child("listing_images/\(listingId)").listAll()
        for item in items.items {
            try await item.delete()
        }
    }
}
