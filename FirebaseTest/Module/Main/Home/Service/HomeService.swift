//
//  HomeService.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 28/04/26.
//

import Foundation
import FirebaseFirestore


class HomeService: HomeProtocol{
    var collectionName: String = "listings"
    let db = Firestore.firestore()
    
    func fetchAllListings(currentUserId: String) async throws -> [ListingModel] {
        let snapShot = try await db.collection(collectionName).getDocuments()
        let listings = snapShot.documents.compactMap { document  in
            do{
                return try document.data(as: ListingModel.self)
            }
            catch{
                print(error)
                return nil
            }
        }
        return listings
    }
    
    
}
