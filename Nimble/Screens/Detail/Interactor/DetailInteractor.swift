//
//  DetailInteractor.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


final class DetailInteractor {
    
    let apiClient: ApiClient
    let idModel: String
    var presenter: DetailPresentationLogic?
    
    init(apiClient: ApiClient, id: String) {
        self.apiClient = apiClient
        self.idModel = id
    }
}

extension DetailInteractor: DetailBusinessLogic {
    
    func fetchDetail() {
        Task {
            do {
                let apiResponse: Result<DetailResponse, ApiClientError> = try await apiClient.sendRequest(method: .get, path: "v1/surveys/\(idModel)", queryItems: nil, body: nil, isAuth: true)
                switch apiResponse {
                case .success(let response):
                    let items = response.included.map {
                        DetailItemsModel(type: $0.type, text: $0.attributes?.text ?? "")
                    }
                    presenter?.presentResult(model: DetailModel(title: response.data.attributes.title, items: items, coverImageUrl: response.data.attributes.coverImageUrl))
                case .failure(_):
                    presenter?.presentServerError()
                }
            } catch {
                presenter?.presentServerError()
            }
        }
    }
}
