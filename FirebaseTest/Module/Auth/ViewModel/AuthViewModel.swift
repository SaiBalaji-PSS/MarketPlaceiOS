//
//  AuthViewModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 24/04/26.
//

import Foundation
import Combine

@MainActor
class AuthViewModel: ObservableObject{
    
    enum AuthState{
        case loading
        case authenticated
        case unauthenticated
    }
    
    @Published var userId: String?
    private var service: AuthServiceProtocol
    @Published var authState: AuthState = .loading
    @Published var showMessage: Bool = false
    @Published var message: String = ""
    
    init(service: AuthServiceProtocol) {
        self.service = service
    }
    
    func signIn(email: String, password: String)async{
      //  self.authState = .loading
        
        do{
            let result = try await service.signIn(email: email, password: password)
            self.userId = result
            self.authState = .authenticated
            self.showMessage = false
            self.message = ""
        }
        catch{
            print(error)
            self.authState = .unauthenticated
            self.message = error.localizedDescription
            self.showMessage = true
        }
    }
    
    func signUp(email: String, password: String,userName: String)async{
       // self.authState = .loading
        do{
            let result = try await service.signUp(email: email, password: password)
            self.userId = result
            
            //upload to cloud store
            let documentId = try await self.service.uploadUserData(user: User(id:self.userId,userName: userName, email: email, createdAt: Date(), profileImageUrl: nil, totalSales: 0.0, itemsSold: 0, itemsPurchased: 0))
            print("USER DOCUMENT ID IS \(documentId)")
            self.authState = .authenticated
            self.message = ""
            self.showMessage = false
        }
        catch{
            print(error)
            self.authState = .unauthenticated
            self.message = error.localizedDescription
            self.showMessage = true
        }
    }
    
    func signOut(){
        //self.authState = .loading
        do{
            try service.signOut()
            self.authState = .unauthenticated
            self.showMessage = false
            self.message = ""
        }
        catch{
            print(error)
            self.authState = .authenticated
            self.showMessage = true
            self.message = error.localizedDescription
        }
    }
    
    func getCurrentUserId() -> String{
        let currentUserId = service.getCurrentSignedInUserId()
        if currentUserId == nil{
            self.authState = .unauthenticated
            self.userId = nil
            return ""
        }
        else{
            self.authState = .authenticated
            self.userId = currentUserId!
            return currentUserId!
        }
    }
    

    
    
    
    
    
}
