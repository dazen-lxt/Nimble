//
//  RemoteItemRepository.swift
//  RickMortyUIKit
//
//  Created by Carlos Mario Muñoz on 24/10/23.
//

import Foundation


class RemoteItemRepository: ItemRepository {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchItems(completion: @escaping CompletionHandler) {
        Task {
            do {
                let apiResponse: Result<ListResponse, ApiClientError> = try await apiClient.sendRequest(method: .get, path: "v1/surveys", queryItems: nil, body: nil, isAuth: true)
                switch apiResponse {
                case .success(let response):
                    let model = response.data.map {
                        SurveyModel(
                            id: $0.id,
                            title: $0.attributes.title,
                            description: $0.attributes.description,
                            coverImageUrl: $0.attributes.coverImageUrl,
                            surveyType: $0.attributes.surveyType,
                            date: $0.attributes.createdAt
                        )
                    }
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveItems(_ items: [SurveyModel]) throws {
        
    }

}
