//
//  AIRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

public protocol AIRepository {
    func transformText(_ text: String) async throws -> String
}
