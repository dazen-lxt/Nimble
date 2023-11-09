//
//  ForgotPasswordEntities.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


struct ForgotPasswordModel: Codable {
    var meta: MetaModel
}

struct MetaModel: Codable {
    var message: String
}
