//
//  ItemRepositoryMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble

class ItemRepositoryMock: ItemRepository {
    var fetchItemsCalled = false
    var saveItemsCalled = false
    var fetchedItems: [SurveyModel] = []

    func fetchItems(completion: @escaping (Result<[SurveyModel], Error>) -> Void) {
        fetchItemsCalled = true
        completion(.success(fetchedItems))
    }

    func saveItems(_ items: [SurveyModel]) throws {
        saveItemsCalled = true
    }
}
