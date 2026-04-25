//
//  AuthServiceProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 24/04/26.
//

import Foundation
import FirebaseCore
import FirebaseAuth

struct UserInfo{
    let providerID: String

    /// The provider's user ID for the user.
    let uid: String

    /// The name of the user.
    let displayName: String?



    /// The user's email address.
    let email: String?

}


protocol AuthServiceProtocol{
    var collectionName: String{get set}
    func signIn(email:String, password: String)async throws -> String
    func signUp(email:String, password: String)async throws -> String
    func signOut() throws
    func getCurrentSignedInUserId() -> String?
    func uploadUserData(user: User)async throws -> String 
    
}

