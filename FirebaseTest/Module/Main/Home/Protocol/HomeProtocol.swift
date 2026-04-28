//
//  HomeProtocol.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 28/04/26.
//

import Foundation

protocol HomeProtocol{
    var collectionName: String{get set}
    func fetchAllListings(currentUserId: String)async throws -> [ListingModel]
}
