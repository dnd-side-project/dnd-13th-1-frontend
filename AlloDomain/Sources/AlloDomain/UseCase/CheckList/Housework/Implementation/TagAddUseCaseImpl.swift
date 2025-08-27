//
//  TagAddUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/27/25.
//

import Foundation

final class TagAddUseCaseImpl {
    private let tagAddRespository: TagAddRespository
    init(tagAddRespository: TagAddRespository) {
        self.tagAddRespository = tagAddRespository
    }
}

extension TagAddUseCaseImpl: TagAddUseCase {
    func execute(groupId: Int, tagName: String) async throws -> TagList {
        return try await tagAddRespository.addTag(groupId: groupId, tagName: tagName)
    }
}
