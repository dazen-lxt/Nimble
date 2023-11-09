//
//  LoginDisplayLogicMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble

class LoginDisplayLogicMock: LoginDisplayLogic {
    var displayLoginSuccessCalled = false
    var displayErrorCalled = false
    var displayedError: String?
    
    func displayLoginSuccess() {
        displayLoginSuccessCalled = true
    }
    
    func displayError(error: String) {
        displayErrorCalled = true
        displayedError = error
    }
}
