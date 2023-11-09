//
//  LoginPresenterTests.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import XCTest
@testable import Nimble


class LoginPresenterTests: XCTestCase {
    var loginPresenter: LoginPresenter!
    var viewMock: LoginDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        loginPresenter = LoginPresenter()
        viewMock = LoginDisplayLogicMock()
        loginPresenter.view = viewMock
    }

    override func tearDown() {
        loginPresenter = nil
        viewMock = nil
        super.tearDown()
    }

    func testPresentLoginSuccess() {
        loginPresenter.presentLoginResult(isSuccess: true)
        XCTAssertTrue(viewMock.displayLoginSuccessCalled)
        XCTAssertFalse(viewMock.displayErrorCalled)
    }

    func testPresentLoginFailure() {
        loginPresenter.presentLoginResult(isSuccess: false)
        XCTAssertFalse(viewMock.displayLoginSuccessCalled)
        XCTAssertTrue(viewMock.displayErrorCalled)
        XCTAssertEqual(viewMock.displayedError, "Invalid credentials")
    }
}
