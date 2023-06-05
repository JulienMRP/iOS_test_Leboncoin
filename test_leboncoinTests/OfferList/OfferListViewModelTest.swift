//
//  OfferListViewModelTest.swift
//  test_leboncoinTests
//
//  Created by Perso on 6/5/23.
//


import XCTest
@testable import test_leboncoin

final class OfferListViewModelTests: XCTestCase {
    var subject: OfferListViewModel!
    let serviceSpy = OfferServiceMock()
    
       override func setUp() {
           super.setUp()
           let coordinator = OfferCoordinator(nav: UINavigationController())
           subject = OfferListViewModel(coordinator: coordinator, apiService: serviceSpy)
       }
       
       func testGetData() {
           XCTAssertEqual(subject.numberOfCells, OfferMocks.shared.getOffers().count)
           XCTAssertEqual(subject.numberOfCategories, OfferMocks.shared.getCategories().count)
       }
    
    func testCategoryNameForId_all() {
        let catName = subject.getCategoryNameForId(id: -1)
        XCTAssertEqual("Tous", catName)
    }
    
    func testCategoryName() {
        let catName = subject.getCategoryNameForId(id: 1)
        XCTAssertEqual("cat0", catName)
    }
    
    func testGetCellViewModel() {
        let data = subject.getCellViewModel(indexPath: IndexPath(row: 0, section: 0))
        let offer = OfferMocks.shared.getOffers()[0]
        XCTAssertEqual(offer.id, data.id)
        XCTAssertEqual(offer.title, data.title)
        XCTAssertEqual(offer.categoryId, data.categoryId)
        XCTAssertEqual(offer.categoryName, data.categoryName)
        XCTAssertEqual(offer.creationDate, data.creationDate)
        XCTAssertEqual(offer.description, data.description)
        XCTAssertEqual(offer.isUrgent, data.isUrgent)
        XCTAssertEqual(offer.imagesUrl.small, data.imagesUrl.small)
        XCTAssertEqual(offer.imagesUrl.thumb, data.imagesUrl.thumb)
        XCTAssertEqual(offer.price, data.price)
        XCTAssertEqual(offer.siret, data.siret)
    }
    
    func testGetCategoryCellViewModel() {
        let data = subject.getCategoryCellViewModel(indexPath: IndexPath(row: 0, section: 0))
        let cat = OfferMocks.shared.getCategories()[0]
        XCTAssertEqual(data.id, cat.id)
        XCTAssertEqual(data.name, cat.name)
    }
    
    func testFilterData_empty() {
        subject.filterData(categoryId: 3)
        XCTAssertEqual(0, subject.numberOfCells)
    }
    
    func testFilterData() {
        subject.filterData(categoryId: 1)
        XCTAssertEqual(1, subject.numberOfCells)
    }
}
