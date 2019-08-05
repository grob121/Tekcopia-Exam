//
//  Order.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import Foundation

struct Order: Codable {
    
    var price: Int
    var categoryId: Int
    var quantity: Int
    var updatedAt: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case price
        case categoryId = "category_id"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try valueContainer.decode(Int.self, forKey: CodingKeys.price)
        self.categoryId = try valueContainer.decode(Int.self, forKey: CodingKeys.categoryId)
        self.quantity = try valueContainer.decode(Int.self, forKey: CodingKeys.quantity)
        self.createdAt = try valueContainer.decode(String.self, forKey: CodingKeys.createdAt)
        self.updatedAt = try valueContainer.decode(String.self, forKey: CodingKeys.updatedAt)
    }
}

struct OrderItems: Codable {
    
    let OrderItems: [Order]
}
