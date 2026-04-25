//
//  AuthTests.swift
//  FirebaseTestTests
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation
import XCTest
@testable import FirebaseTest

@MainActor
final class AuthTests: XCTestCase{
    var mockService: MockAuthService!
    var sut: AuthViewModel!
    
    override func setUp()   {
        super.setUp()
        self.mockService = MockAuthService()
        self.sut = AuthViewModel(service: mockService)
    }
    
    override func tearDown() {
        self.mockService = nil
        self.sut = nil
        super.tearDown()
    }
    
    
    func test_initialState() {
        XCTAssertEqual(sut.authState, .loading)
        XCTAssertNil(sut.userId)
        XCTAssertFalse(sut.showMessage)
        XCTAssertEqual(sut.message, "")
    }
    
    func test_signInSuccess()async {
        await self.sut.signIn(email: "ksbalaji2022@gmail.com", password: "test@123")
        XCTAssertEqual(self.sut.authState, .authenticated)
        XCTAssertNotNil(self.sut.userId)
    }
    
    
    func test_signInFailed()async{
        self.mockService.shouldThrowError = true
        self.mockService.errorToBeThrown = .invalidCredentials
        await self.sut.signIn(email: "test", password: "test")
        XCTAssertEqual(self.sut.authState, .unauthenticated)
        XCTAssertNil(self.sut.userId)
        XCTAssertEqual(self.sut.showMessage, true)
        XCTAssertFalse(sut.message.isEmpty)
    }
    
    func test_signUpSuccess()async{
        await self.sut.signUp(email: "ksbalaji2022@gmail.com", password: "test@123")
        XCTAssertEqual(self.sut.authState, .authenticated)
        XCTAssertNotNil(self.sut.userId)
    }
    
    
    func test_signUpFailed()async{
        self.mockService.shouldThrowError = true
        self.mockService.errorToBeThrown = .emailAlreadyExist
        await self.sut.signUp(email: "ksbalaji2022@gmail.com", password: "test@123")
        XCTAssertEqual(self.sut.authState, .unauthenticated)
        XCTAssertNil(self.sut.userId)
        XCTAssertEqual(self.sut.showMessage, true)
        XCTAssertFalse(sut.message.isEmpty)
    }
    
    
    func test_signOutSuccess(){
        self.sut.signOut()
        XCTAssertEqual(self.sut.authState, .unauthenticated)
    }
    
    func test_signOutFailed(){
        self.mockService.shouldThrowError = true
        self.mockService.errorToBeThrown = .unableToSignOut
        self.sut.signOut()
        XCTAssertEqual(self.sut.authState, .authenticated)
        XCTAssertEqual(self.sut.showMessage, true)
        
    }
    
    func test_getCurrentUserIdSuccess(){
        self.mockService.shouldThrowError = false
        let _ = self.sut.getCurrentUserId()
        XCTAssertNotNil(self.sut.userId)
        XCTAssertEqual(self.sut.authState, .authenticated)
    }
    
    func test_getCurrentUserIdFailed(){
        self.mockService.shouldThrowError = true
        let _ = self.sut.getCurrentUserId()
        XCTAssertNil(self.sut.userId)
        XCTAssertEqual(self.sut.authState, .unauthenticated)
    }
    
}
