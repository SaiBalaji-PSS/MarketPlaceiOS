//
//  MyListingViewModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 27/04/26.
//

import Foundation
import Combine

@MainActor
class MyListingViewModel: ObservableObject{
    enum MyListingState{
        case idle
        case loading
       
    }
    
    
    private var service: MyListingProtocol
    @Published var showMessage: Bool = false
    @Published var message: String = ""
    @Published var myListings = [ListingModel]()
    @Published var state: MyListingState = .idle
    
    
    
    init(service: MyListingProtocol) {
        self.service = service
    }
    
    func getMyListings(userId: String)async{
        defer{
            self.state = .idle
        }
        self.state = .loading
        do{
            let result = try await service.fetchMyListings(userId: userId)
            self.myListings = result
        }
        catch{
            print(error)
            self.showMessage = true
            self.message = error.localizedDescription
        }
    }
    
    func deleteMyListing(listingId: String)async {
        defer{
            self.state = .idle
        }
        self.state = .loading
        do{
            try await self.service.deleteMyListing(listingId: listingId)
            try await self.service.deleteListingImages(listingId: listingId)
            self.showMessage = true
            self.message = "The listing has been deleted success fully"
        }
        catch{
            print(error)
            self.showMessage = true
            self.message = error.localizedDescription
        }
    }
}
