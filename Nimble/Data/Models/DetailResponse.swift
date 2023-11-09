//
//  DetailResponse.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation

struct DetailResponse: Codable {
    var data: ItemDataResponse
    var included: [DetailIncludedResponse]
}

struct DetailIncludedResponse: Codable {
    var type: String
    var attributes: DetailAttributesResponse?
}

struct DetailAttributesResponse: Codable {
    var text: String?
}
