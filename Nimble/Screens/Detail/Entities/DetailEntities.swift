//
//  DetailEntities.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


struct DetailModel {
    var title: String
    var items: [DetailItemsModel]
    var coverImageUrl: String
}

struct DetailItemsModel {
    var type: String
    var text: String
}

struct DetailViewModel {
    var title: String
    var question: String
    var answers: [String]
    var coverImageUrl: String
}
