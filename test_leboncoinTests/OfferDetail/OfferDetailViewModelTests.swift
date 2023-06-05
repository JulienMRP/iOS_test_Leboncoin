//
//  OfferDetailViewModelTests.swift
//  test_leboncoinTests
//
//  Created by Perso on 6/5/23.
//

import XCTest
@testable import test_leboncoin

final class OfferDetailViewModelTests: XCTestCase {
    var subject: OfferDetailViewModel!
    let offer = Offer(id: 1,
                      title: "test",
                      categoryId: 0,
                      creationDate: "date",
                      description: "desc",
                      isUrgent: false,
                      imagesUrl: Image(small: "sm", thumb: "th"),
                      price: 34,
                      siret: nil)
 
    override func setUp() {
        super.setUp()
        let coordinator = OfferCoordinator(nav: UINavigationController())
        subject = OfferDetailViewModel(coordinator: coordinator, offer: offer)
    }
    
    func testGetData() {
        let data = subject.getData()
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

}
