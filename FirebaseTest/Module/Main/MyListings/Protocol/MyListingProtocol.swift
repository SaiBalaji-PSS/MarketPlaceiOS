//
//  MyListingProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 27/04/26.
//

import Foundation

protocol MyListingProtocol{
    var collectionName: String{get set}
    func fetchMyListings(userId: String)async throws -> [ListingModel]
    func deleteMyListing(listingId: String)async throws
    func deleteListingImages(listingId: String?)async throws 
}
