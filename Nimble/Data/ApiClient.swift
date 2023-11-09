//
//  ApiClient.swift
//
//  Created by Carlos Mario Muñoz on 18/10/23.
//

import Foundation

protocol ApiClient {
    func sendRequest<T: Decodable>(method: HttpMethod, path: String, queryItems: [URLQueryItem]?, body: [String: Any]?, isAuth: Bool) async throws -> Result<T, ApiClientError>
}

class ApiClientImpl: ApiClient {

    private let urlSession = URLSession.shared
    private let baseURL: URL = URL(string: "https://survey-api.nimblehq.co/api/")!

    func sendRequest<T: Decodable>(method: HttpMethod, path: String, queryItems: [URLQueryItem]?, body: [String: Any]?, isAuth: Bool) async throws -> Result<T, ApiClientError> {
        var urlComponent = URLComponents(string: baseURL.appendingPathComponent(path).absoluteString)!
        if let queryItems = queryItems {
            urlComponent.queryItems = queryItems
        }
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue


        if let body = body, let bodyData = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = bodyData
        }
        
        if isAuth, let tokenInfo = KeychainManager.shared.getTokenInfo() {
            print("\(tokenInfo.tokenType) \(tokenInfo.accessToken)")
            request.addValue("\(tokenInfo.tokenType) \(tokenInfo.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await urlSession.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        guard httpResponse?.statusCode == 200 else {
            if httpResponse?.statusCode == 401 && isAuth {
                let refreshResult = try? await refreshToken()
                if refreshResult == true {
                    return try await sendRequest(method: method, path: path, queryItems: queryItems, body: body, isAuth: isAuth)
                } else {
                    NotificationCenter.default.post(name: .userShouldLogout, object: nil)
                    return .failure(.tokenExpired)
                }
            }
            return .failure(.invalidStatusCode(statusCode: httpResponse?.statusCode ?? 0))
        }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch(let error) {
            print("Decoding error: \(error.localizedDescription)")
            return .failure(.decodingError(error: error))
        }
    }
    
    private func refreshToken() async throws -> Bool {
        guard let tokenInfo = KeychainManager.shared.getTokenInfo() else {
            return false
        }
        print("REFRESHING")
        let urlComponent = URLComponents(string: baseURL.appendingPathComponent("v1/oauth/token").absoluteString)!
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = HttpMethod.post.rawValue
        let body: [String: Any] = [
            "grant_type": "refresh_token",
            "refresh_token": tokenInfo.refreshToken,
            "client_id": "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw",
            "client_secret": "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw",
        ]

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            return false
        }
        request.httpBody = bodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await urlSession.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        guard httpResponse?.statusCode == 200 else {
            return false
        }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let decodedData = try decoder.decode(LoginResponse.self, from: data)
            let tokenInfo = TokenInfo(
                accessToken: decodedData.data.attributes.accessToken,
                refreshToken: decodedData.data.attributes.refreshToken,
                tokenType: decodedData.data.attributes.tokenType
            )
            return KeychainManager.shared.saveTokenInfo(tokenInfo: tokenInfo)
        } catch {
            return false
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ApiClientError: Error {
    case invalidStatusCode(statusCode: Int)
    case decodingError(error: Error)
    case tokenExpired
}
