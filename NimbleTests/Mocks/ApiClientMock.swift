//
//  ApiClientMock.swift
//  NimbleTests
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
@testable import Nimble

class ApiClientMock: ApiClient {
    var sendRequestCalled = false
    var sendRequestMethod: HttpMethod?
    var sendRequestPath: String?
    var sendRequestBody: [String: Any]?
    var sendRequestIsAuth: Bool = false
    var fakeApiClientErrorResponse: ApiClientError?
    var fakeSuccessResponse: Codable?

    func sendRequest<T: Decodable>(method: HttpMethod, path: String, queryItems: [URLQueryItem]?, body: [String: Any]?, isAuth: Bool) async throws -> Result<T, ApiClientError> {
        sendRequestCalled = true
        sendRequestMethod = method
        sendRequestPath = path
        sendRequestBody = body
        sendRequestIsAuth = isAuth
        print("sendRequestCalled Mock: \(sendRequestCalled)")
        if let fakeSuccessResponse = fakeSuccessResponse as? T {
            return .success(fakeSuccessResponse)
        } else if let fakeApiClientErrorResponse = fakeApiClientErrorResponse {
            return .failure(fakeApiClientErrorResponse)
        } else {
            fatalError("No se ha configurado una respuesta ficticia en el mock.")
        }
    }
}
