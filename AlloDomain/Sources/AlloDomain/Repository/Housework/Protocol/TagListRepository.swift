//
//  TagListRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

public protocol TagListRepository: Sendable {
    func getTagList(groupId: Int) async throws -> [TagList]
}
