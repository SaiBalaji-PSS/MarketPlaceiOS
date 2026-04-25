//
//  User.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation
import FirebaseFirestore


struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let userName: String
    let email: String
    let createdAt: Date
    let profileImageUrl: String?
    var totalSales: Double
    var itemsSold: Int
    var itemsPurchased: Int

    private enum CodingKeys: String, CodingKey {
       
        case userName = "user_name" //snake case for db column names
        case email
        case createdAt = "created_at"
        case profileImageUrl = "profile_image_url"
        case totalSales = "total_sales"
        case itemsSold = "items_sold_count"
        case itemsPurchased = "items_purchased_count"
    }
}


extension User {
    static var mock: User {
        User(
            id: "user_123",
            userName: "SaiBalaji",
            email: "saibalaji@example.com",
            createdAt: Date(),
            profileImageUrl: "https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/1ebc8dae_cc4d_4d12_b35d_c8ca22e585cd.jpeg",
            totalSales: 1200.50,
            itemsSold: 25,
            itemsPurchased: 10
        )
    }
}
