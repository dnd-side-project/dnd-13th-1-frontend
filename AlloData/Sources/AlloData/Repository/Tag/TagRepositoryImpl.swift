//
//  TagRepositoryImpl.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

final class TagRepositoryImpl: TagRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchTags() async throws -> [TagItem] {
        guard let groupId = UserDefaultsService.groupId else { return [] }
        let dto = try await networkService.getTagList(groupId)
        return dto.map { TagItem(id: $0.tagId, name: $0.name) }
    }
    
    func addTag(name: String) async throws -> TagItem {
        guard let groupId = UserDefaultsService.groupId else { throw NSError(domain: "GroupIdMissing", code: -1) }
        print("[TagRepository] addTag 요청 전 - groupId: \(groupId), name: \(name)")
        let dto = try await networkService.addTag(groupId, tagName: name)
        print("[TagRepository] addTag 응답 - tagId: \(dto.tagId), name: \(dto.name)")
        return TagItem(id: dto.tagId, name: dto.name)
    }
}
