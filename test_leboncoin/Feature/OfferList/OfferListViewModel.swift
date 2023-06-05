//
//  OfferListViewModel.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import Foundation


final class OfferListViewModel: NSObject {
    private var apiService: OfferService!
    private var coordinator: OfferCoordinator
    
    private var data: [Offer] = [Offer]()
    private(set) var filteredData: [Offer] = [Offer]() {
        didSet {
            self.bindDataToController()
        }
    }
    private(set) var categories: [Category] = [Category]() {
        didSet {
            self.bindCategoriesToController()
        }
    }
    
    var bindDataToController : (() -> ()) = {}
    var bindCategoriesToController : (() -> ()) = {}
    var onErrorHandling : ((ErrorResult) -> ()) = { _ in }
    
    var numberOfCells: Int {
        return filteredData.count
    }
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    init(coordinator: OfferCoordinator, apiService: OfferService) {
        self.apiService = apiService
        self.coordinator = coordinator
        super.init()
        getCategories()
    }
    
    
    func filterData(categoryId: Int) {
        self.filteredData = data.filter({ offer in
            offer.categoryId == categoryId || categoryId == -1
        })
    }
    
    private func getCategories() {
        apiService.getCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.onErrorHandling(error)
            case .success(let categories):
                self.categories = categories.sorted { $0.id < $1.id }
                self.getData()
            }
                        
        }
    }
    
    private func getData() {
        apiService.getOffers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.onErrorHandling(error)
            case .success(let offers):
                let sortedOffers = offers
                    .sorted { $0.creationDate.isAfter($1.creationDate) }
                    .sorted { $0.isUrgent && !$1.isUrgent }
                self.data = sortedOffers
                self.filteredData = sortedOffers
            }
            
            
        }
    }
    
    func getCategoryNameForId(id: Int) -> String {
        if id == -1 { return "Tous" }
        guard id <= categories.count else { return "Aucune catégorie" }
        return categories[id-1].name
    }
    
    func getCellViewModel(indexPath: IndexPath) -> Offer {
        var offer = filteredData [indexPath.row]
        offer.categoryName = getCategoryNameForId(id: offer.categoryId)
        return offer
    }
    
    func getCategoryCellViewModel(indexPath: IndexPath) -> Category {
        let category = categories[indexPath.row]
        return category
    }
    
    func didSelectIndex(index: IndexPath) {
        let offer = getCellViewModel(indexPath: index)
        coordinator.showDetailedOffer(offer: offer)
    }
}
