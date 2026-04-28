//
//  HomeViewModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 28/04/26.
//

import Foundation
import Combine




@MainActor
class HomeViewModel: ObservableObject{
    enum ViewModelState{
        case idle
        case loading
    }
    private var service: HomeProtocol
    @Published var listings: [ListingModel] = [ListingModel]()
    @Published var vmState: ViewModelState = .idle
    @Published var showMessage: Bool = false
    @Published var message: String = ""
    
    
    init(service: HomeProtocol) {
        self.service = service
    }
    
    func getAllListings(currentUserId: String)async{
        
        defer{
            self.vmState = .idle
        }
        self.vmState = .loading
        do{
            let result = try await service.fetchAllListings(currentUserId: currentUserId)
            self.listings = result
        }
        catch{
            print(error)
        }
    }
    
    
    
}
