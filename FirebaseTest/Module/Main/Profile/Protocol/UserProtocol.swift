//
//  UserProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation


protocol UserProtocol{
    var collectionName: String {get set}
    var storageName: String{get set}
    func fetchUserData(id: String)async throws -> User
    func uploadUserData(user: User)async throws -> String
    func uploadProfileImage(id: String,imageData: Data)async throws -> URL
    func updateProfileImageURLInDB(id: String,url: String)async throws
    
}

