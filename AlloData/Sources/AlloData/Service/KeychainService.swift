//
//  KeychainService.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import Security

public struct KeychainService {
    private static let service = "com.dnd.allo"

    enum KeyChainError: Error {
        case saveError
        case getError
        case deleteError
    }
    
    public static func save(token: String, key: String) throws {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        // 기존에 같은 키로 저장된 아이템이 있다면 삭제
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeyChainError.saveError }
    }
    
    public static func get(key: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String         : kSecClassGenericPassword,
            kSecAttrService as String   : service,
            kSecAttrAccount as String   : key,
            kSecReturnData as String    : kCFBooleanTrue!,
            kSecMatchLimit as String    : kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess,
              let data = item as? Data,
              let token = String(data: data, encoding: .utf8)
        else { throw KeyChainError.getError }
        return token
    }
    
    public static func delete(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound
        else { throw KeyChainError.deleteError }
    }
}
