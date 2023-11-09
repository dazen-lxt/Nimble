//
//  LoginResponse.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation

struct LoginResponse: Codable {
    var data: LoginDataResponse
}

struct LoginDataResponse: Codable {
    var attributes: LoginAttributesResponse
}

struct LoginAttributesResponse: Codable {
    var accessToken: String
    var tokenType: String
    var refreshToken: String
   
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
    }
}
