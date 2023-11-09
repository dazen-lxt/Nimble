//
//  ListInteractorTests.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import XCTest
@testable import Nimble

class ListInteractorTests: XCTestCase {
    var interactor: ListInteractor!
    var presenterMock: ListPresenterMock!
    var remoteRepositoryMock: ItemRepositoryMock!
    var localRepositoryMock: ItemRepositoryMock!

    override func setUp() {
        super.setUp()
        presenterMock = ListPresenterMock()
        remoteRepositoryMock = ItemRepositoryMock()
        localRepositoryMock = ItemRepositoryMock()
        interactor = ListInteractor(localRepository: localRepositoryMock, remoteRepository: remoteRepositoryMock)
        interactor.presenter = presenterMock
    }

    func testFetchList() {
        let fakeItems = [
            SurveyModel(id: "", title: "", description: "", coverImageUrl: "", surveyType: "", date: Date()),
            SurveyModel(id: "", title: "", description: "", coverImageUrl: "", surveyType: "", date: Date())
        ]
        remoteRepositoryMock.fetchedItems = fakeItems

        interactor.fetchList()

        XCTAssertTrue(remoteRepositoryMock.fetchItemsCalled)
        XCTAssertTrue(presenterMock.presentResultCalled)
        XCTAssertEqual(presenterMock.presentedItems.count, fakeItems.count)
    }
}
