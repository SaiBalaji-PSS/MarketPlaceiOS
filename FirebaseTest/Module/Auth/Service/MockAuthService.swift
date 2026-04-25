//
//  MockAuthService.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation

class MockAuthService: AuthServiceProtocol{
    var collectionName: String = "users"
    
  
    
    enum MockAuthServiceError: Error{
        case invalidCredentials
        case emailAlreadyExist
        case unableToSignOut
        case unableToUploadUserData
        case unknown
    }
    var shouldThrowError: Bool = false
    var errorToBeThrown: MockAuthServiceError = .unknown
    var testUserId: String?
    
    
    
    func signIn(email: String, password: String) async throws -> String {
        if shouldThrowError{
            throw errorToBeThrown
        }
        testUserId = "12345678"
        return testUserId!
    }
    
    func signUp(email: String, password: String) async throws -> String {
        if shouldThrowError{
            throw errorToBeThrown
        }
        testUserId = "12345678"
        return testUserId!
    }
    
    func signOut() throws {
        if shouldThrowError{
            throw errorToBeThrown
        }
    }
    
    func getCurrentSignedInUserId() -> String? {
        if shouldThrowError{
            testUserId = nil
            return testUserId
        }
        testUserId = "12345678"
        return testUserId
    }
    
    func uploadUserData(user: User) async throws -> String {
        if shouldThrowError{
            throw errorToBeThrown
        }
        testUserId = "12345678"
        return testUserId!
    }
    
    
}
