//
//  ListDisplayLogicMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble

class ListDisplayLogicMock: ListDisplayLogic {
    var displayViewModelsCalled = false
    var displayedViewModels: [SurveyViewModel] = []

    func displayViewModels(items: [SurveyViewModel]) {
        displayViewModelsCalled = true
        displayedViewModels = items
    }
}
