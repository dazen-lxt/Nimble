//
//  LoginEntities.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


struct TokenInfo: Codable {
    var accessToken: String
    var refreshToken: String
    var tokenType: String
}
