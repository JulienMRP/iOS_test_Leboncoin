//
//  OfferMocks.swift
//  test_leboncoinTests
//
//  Created by Perso on 6/5/23.
//

import Foundation

class OfferMocks {
    static let shared = OfferMocks()
    private let offers = [Offer(id: 1,
                        title: "test",
                        categoryId: 1,
                        categoryName: "cat0",
                        creationDate: "date",
                        description: "desc",
                        isUrgent: false,
                        imagesUrl: Image(small: "sm", thumb: "th"),
                        price: 34,
                        siret: nil)]
    
    private let categories = [Category(id: 1, name: "cat0"),
                              Category(id: 2, name: "cat1")]
    func getOffers() -> [Offer] {
        return offers
    }
    
    func getCategories() -> [Category] {
        return categories
    }
}
