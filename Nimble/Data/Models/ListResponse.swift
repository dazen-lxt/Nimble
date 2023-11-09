//
//  ItemModel.swift
//  RickMortyUIKit
//
//  Created by Carlos Mario Muñoz on 18/10/23.
//

import Foundation

struct ListResponse: Codable {
    var data: [ItemDataResponse]
}

struct ItemDataResponse: Codable {
    var id: String
    var attributes: ItemAttributesResponse
}

struct ItemAttributesResponse: Codable {
    var title: String
    var description: String
    var coverImageUrl: String
    var createdAt: Date
    var surveyType: String
   
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case coverImageUrl = "cover_image_url"
        case createdAt = "created_at"
        case surveyType = "survey_type"
    }
}
