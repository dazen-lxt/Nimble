//
//  LoginInteractorMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble


class LoginInteractorMock: LoginBusinessLogic {
    var loginUserCalled = false
    var loginUsername: String?
    var loginPassword: String?

    func loginUser(username: String, password: String) {
        loginUserCalled = true
        loginUsername = username
        loginPassword = password
    }
}
