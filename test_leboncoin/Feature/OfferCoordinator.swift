//
//  Coordinator.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import UIKit

protocol OfferCoordinatorLogic: Coordinator {
    func showDetailedOffer(offer: Offer)
}

class OfferCoordinator: OfferCoordinatorLogic {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        navigationController = nav
    }
    
    func start() {
        let viewModel = OfferListViewModel(coordinator: self)
        let viewController = OfferListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetailedOffer(offer: Offer) {
        let vm = OfferDetailViewModel(coordinator: self, offer: offer)
        let vc = OfferDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
