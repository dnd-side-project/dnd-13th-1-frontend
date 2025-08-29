//
//  TagAddRespository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/27/25.
//

import Foundation

public protocol TagAddRespository: Sendable {
    func addTag(groupId: Int, tagName: String) async throws -> TagList
}

