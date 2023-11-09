//
//  LoginInteractor.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


final class LoginInteractor {
    
    let apiClient: ApiClient
    var presenter: LoginPresentationLogic?
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension LoginInteractor: LoginBusinessLogic {
    
    func loginUser(username: String, password: String) {
        let body: [String: Any] = [
            "grant_type": "password",
            "email": username,
            "password": password,
            "client_id": "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw",
            "client_secret": "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw",
        ]
        Task {
            do {
                let apiResponse: Result<LoginResponse, ApiClientError> = try await apiClient.sendRequest(method: .post, path: "v1/oauth/token", queryItems: nil, body: body, isAuth: false)
                switch apiResponse {
                case .success(let response):
                    let tokenInfo = TokenInfo(
                        accessToken: response.data.attributes.accessToken,
                        refreshToken: response.data.attributes.refreshToken,
                        tokenType: response.data.attributes.tokenType
                    )
                    let result = KeychainManager.shared.saveTokenInfo(tokenInfo: tokenInfo)
                    presenter?.presentLoginResult(isSuccess: result)
                case .failure(_):
                    presenter?.presentLoginResult(isSuccess: false)
                }
            } catch {
                presenter?.presentLoginResult(isSuccess: false)
            }
        }
    }
}
