//
//  Ad.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import Foundation

struct Offer: Decodable {
    let id: Int
    let title: String
    let categoryId: Int
    var categoryName: String?
    let creationDate: String
    let description: String
    let isUrgent: Bool
    let imagesUrl: Image
    let price: Double
    let siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case categoryId = "category_id"
        case categoryName
        case creationDate = "creation_date"
        case description
        case isUrgent = "is_urgent"
        case imagesUrl = "images_url"
        case price
        case siret
    }
}
