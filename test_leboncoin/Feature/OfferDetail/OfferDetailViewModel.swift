//
//  OfferDetailViewModel.swift
//  test_leboncoin
//
//  Created by Perso on 6/1/23.
//

import Foundation

final class OfferDetailViewModel: NSObject {
    private var coordinator: OfferCoordinator
    private var offer: Offer!
    
    init(coordinator: OfferCoordinator!, offer: Offer!) {
        self.coordinator = coordinator
        self.offer = offer
        super.init()
    }
    
    func getData() -> Offer {
        return offer
    }
    
}
