//
//  TagListUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

final class TagListUseCaseImpl {
    private let tagListRepository: TagListRepository
    init(tagListRepository: TagListRepository) {
        self.tagListRepository = tagListRepository
    }
}

extension TagListUseCaseImpl: TagListUseCase {
    func execute(groupId: Int) async throws -> [TagList] {
        return try await tagListRepository.getTagList(groupId: groupId)
    }
}
