//
//  ListPresenterTests.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import XCTest
@testable import Nimble

class ListPresenterTests: XCTestCase {
    
    var presenter: ListPresenter!
    var displayLogicMock: ListDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        presenter = ListPresenter()
        displayLogicMock = ListDisplayLogicMock()
        presenter.view = displayLogicMock
    }
    
    override func tearDown() {
        presenter = nil
        displayLogicMock = nil
        super.tearDown()
    }
    
    func testPresentResult() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let sampleDate = dateFormatter.date(from: "Tuesday, June 6")!
        let sampleItem = SurveyModel(
            id: "Sample Id",
            title: "Sample Title",
            description: "Sample Description",
            coverImageUrl: "sample-image-url",
            surveyType: "Q",
            date: sampleDate
        )
        let sampleItems = [sampleItem]
        
        presenter.presentResult(items: sampleItems)
        
        
        XCTAssertTrue(displayLogicMock.displayViewModelsCalled)
        XCTAssertEqual(displayLogicMock.displayedViewModels.count, 1)
        let displayedViewModel = displayLogicMock.displayedViewModels[0]
        XCTAssertEqual(displayedViewModel.title, "Sample Title")
        XCTAssertEqual(displayedViewModel.description, "Sample Description")
        XCTAssertEqual(displayedViewModel.coverImageUrl, "sample-image-url")
        XCTAssertEqual(displayedViewModel.surveyType, "Q")
        XCTAssertEqual(displayedViewModel.date, "TUESDAY, JUNE 6")
    }
    
}
