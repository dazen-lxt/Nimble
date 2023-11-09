//
//  KeyManager.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()

    private let service = "Nimble"
    
    func saveTokenInfo(tokenInfo: TokenInfo) -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tokenInfo)
            
            var query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecValueData: data,
                kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
            ]
            
            var status = SecItemCopyMatching(query as CFDictionary, nil)
            if status == errSecSuccess {
                status = SecItemUpdate(query as CFDictionary, [kSecValueData: data] as CFDictionary)
            } else {
                query[kSecValueData] = data
                query[kSecAttrAccessible] = kSecAttrAccessibleWhenUnlocked
                status = SecItemAdd(query as CFDictionary, nil)
            }
            return status == errSecSuccess
        } catch {
            print("Error encoding TokenInfo: \(error)")
            return false
        }
    }

    func getTokenInfo() -> TokenInfo? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            do {
                let decoder = JSONDecoder()
                let tokenInfo = try decoder.decode(TokenInfo.self, from: data)
                return tokenInfo
            } catch {
                print("Error decoding TokenInfo: \(error)")
                return nil
            }
        }
        
        return nil
    }

    func deleteTokenInfo() -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
