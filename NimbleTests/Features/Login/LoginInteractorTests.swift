//
//  LoginInteractorTests.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import XCTest
@testable import Nimble

class LoginInteractorTests: XCTestCase {
    var loginInteractor: LoginInteractor!
    var apiClientMock: ApiClientMock!

    override func setUp() {
        super.setUp()
        apiClientMock = ApiClientMock()
        loginInteractor = LoginInteractor(apiClient: apiClientMock)
    }

    override func tearDown() {
        loginInteractor = nil
        apiClientMock = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        apiClientMock.fakeSuccessResponse = LoginResponse(data: LoginDataResponse(attributes: LoginAttributesResponse(accessToken: "", tokenType: "", refreshToken: "")))
        loginInteractor.loginUser(username: "usuario", password: "contraseña")
        XCTAssertTrue(apiClientMock.sendRequestCalled)
    }

    func testLoginFailure() {
        apiClientMock.fakeApiClientErrorResponse = .invalidStatusCode(statusCode: 401)
        loginInteractor.loginUser(username: "usuario", password: "contraseña")
        XCTAssertTrue(apiClientMock.sendRequestCalled)
    }
}
