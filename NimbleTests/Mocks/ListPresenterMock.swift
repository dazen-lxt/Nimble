//
//  ListPresenterMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble

class ListPresenterMock: ListPresentationLogic {
    var presentResultCalled = false
    var presentedItems: [SurveyModel] = []

    func presentResult(items: [SurveyModel]) {
        presentResultCalled = true
        presentedItems = items
    }
}
