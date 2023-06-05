//
//  OfferServiceMock.swift
//  test_leboncoinTests
//
//  Created by Perso on 6/5/23.
//


class OfferServiceMock: OfferService {
    
    override func getOffers(completion: @escaping (Result<[Offer], ErrorResult>) -> ()) {
        completion(Result.success(OfferMocks.shared.getOffers()))
    }

    override func getCategories(completion: @escaping (Result<[Category], ErrorResult>) -> ()) {
        completion(Result.success(OfferMocks.shared.getCategories()))
    }
}
