//
//  TagListUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

public protocol TagListUseCase: Sendable {
    func execute(groupId: Int) async throws -> [TagList]
}
