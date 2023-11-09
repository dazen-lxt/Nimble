//
//  ItemRepository.swift
//  RickMortyUIKit
//
//  Created by Carlos Mario Muñoz on 24/10/23.
//

import Foundation

protocol ItemRepository {
    typealias CompletionHandler = (Result<[SurveyModel], Error>) -> Void

    func fetchItems(completion: @escaping CompletionHandler)
    func saveItems(_ items: [SurveyModel])  throws
}
