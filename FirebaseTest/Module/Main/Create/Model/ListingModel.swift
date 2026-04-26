//
//  ListingModel.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import Foundation
import FirebaseFirestore

struct ListingModel: Codable {
    @DocumentID var listingId: String?
    let sellerId: String //user id of logged in user who upload the listing
    let productName: String
    let quantity: Int
    let price: Double
    var imageUrls: [String]
    let createdDate: Date
    enum CodingKeys: String, CodingKey {
        case listingId = "listing_id"
        case sellerId = "seller_id"
        case productName = "product_name"
        case quantity
        case price
        case imageUrls = "image_urls"
        case createdDate = "created_date"
    }
}
