//
//  TagListRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation
import AlloDomain

final class TagListRepositoryImpl: TagListRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getTagList(groupId: Int) async throws -> [TagList] {
        let dto = try await networkService.getTagList(groupId)
        return dto.map { TagList(tagId: $0.tagId, name: $0.name) }
    }
}
