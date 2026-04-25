//
//  UserProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol UserProtocol{
    var collectionName: String {get set}
    var storageName: String{get set}
    func fetchUserData(id: String)async throws -> User
    func uploadUserData(user: User)async throws -> String
    func uploadProfileImage(id: String,imageData: Data)async throws -> URL
    func updateProfileImageURLInDB(id: String,url: String)async throws
    
}

class ProfileFireStoreService: UserProtocol{
 
    
    var collectionName: String = "users"
    var storageName: String = "profile_images"
    
    let db = Firestore.firestore()
    
    func fetchUserData(id: String) async throws -> User {
        let ref = db.collection(collectionName)
        let userData  = try await ref.document(id).getDocument(as: User.self)
        return userData
    }
    
    func uploadUserData(user: User)async throws -> String {
        guard let id = user.id else{throw NSError(domain: "Missing Id", code: 0) }
        
        try  await db.collection(collectionName)
            .document(id)
            .setData([
                "email": user.email,
                "user_name": user.userName,
                "created_at": user.createdAt,
                "profile_image_url": user.profileImageUrl ?? "",
                "total_sales": user.totalSales,
                "items_sold_count": user.itemsSold,
                "items_purchased_count": user.itemsPurchased
                
            ], merge: true)

        return id
    }
    
    func uploadProfileImage(id: String,imageData: Data) async throws -> URL {
        let profileImageRef = Storage.storage().reference().child("profile_image/\(id).jpg")
        let storageMetaData = try await profileImageRef.putDataAsync(imageData)
        let fileUrl = try await profileImageRef.downloadURL()
        return fileUrl
    }
    
    func updateProfileImageURLInDB(id: String, url: String) async throws {
        try await db.collection(collectionName)
            .document(id)
            .updateData([
                "profile_image_url": url
            ])
        
    }
}
