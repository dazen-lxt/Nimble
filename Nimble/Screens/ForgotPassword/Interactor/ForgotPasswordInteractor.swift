//
//  ForgotPasswordInteractor.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


final class ForgotPasswordInteractor {
    
    let apiClient: ApiClient
    var presenter: ForgotPasswordPresentationLogic?
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension ForgotPasswordInteractor: ForgotPasswordBusinessLogic {
    
    func sendForgotPassword(email: String) {
        let userData: [String: Any] = [
            "email": email
        ]
        let body: [String: Any] = [
            "user": userData,
            "client_id": "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw",
            "client_secret": "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw",
        ]
        Task {
            do {
                let apiResponse: Result<ForgotPasswordModel, ApiClientError> = try await apiClient.sendRequest(method: .post, path: "v1/passwords", queryItems: nil, body: body, isAuth: false)
                switch apiResponse {
                case .success(let response):
                    presenter?.presentForgotPasswordResult(isSuccess: true, model: response)
                case .failure(_):
                    presenter?.presentForgotPasswordResult(isSuccess: false, model: nil)
                }
            } catch {
                presenter?.presentForgotPasswordResult(isSuccess: false, model: nil)
            }
        }
    }
}
