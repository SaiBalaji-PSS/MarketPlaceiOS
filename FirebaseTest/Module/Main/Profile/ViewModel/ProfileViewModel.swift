//
//  ProfileViewModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject{
    @Published var userData: User?
    @Published var showMessage: Bool = false
    @Published var message: String = ""
    @Published var isLoading: Bool = false
    private var service: UserProtocol
    
    init(service: UserProtocol) {
        self.service = service
    }
    
    func getProfileInfo(id: String)async {
        defer{
            isLoading = false
        }
        self.isLoading = true 
        do{
            let result = try await service.fetchUserData(id: id)
            self.userData = result
        }
        catch{
            print(error)
            self.showMessage = true
            self.message = error.localizedDescription
        }
    }
    
    func uploadProfileImage(id: String,imageData: Data)async {
        defer{
            isLoading = false
        }
        isLoading = true 
        do{
            let fileUrl = try await service.uploadProfileImage(id: id, imageData: imageData)
            print(fileUrl)
            try await service.updateProfileImageURLInDB(id: id, url: fileUrl.absoluteString)
            self.userData = try await service.fetchUserData(id: id)
        }
        catch{
            print(error)
            self.showMessage = true
            self.message = error.localizedDescription
        }
    }
}

extension Date{
    func getFormattedCreatedDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        return formatter.string(from: self)
    }
}
