//
//  TagAddUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/27/25.
//

import Foundation

public protocol TagAddUseCase: Sendable {
    func execute(groupId: Int, tagName: String) async throws -> TagList
}
