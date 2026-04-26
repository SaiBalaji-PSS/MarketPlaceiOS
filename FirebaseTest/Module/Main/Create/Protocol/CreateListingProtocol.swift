//
//  CreateListingProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import Foundation

protocol CreateListingProtocol{
    var collectionName: String {get set}
    
    func uploadListing(listing: ListingModel) async throws -> String //returns inserted document id
    func uploadImages(imageData: [Data],listingId: String?) async throws-> [String] // listingId will be the folder name for the iamges returns bucket urls in string
    func deleteListingImages(listingId: String?)async throws
}
