//
//  TagAddRespositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/27/25.
//

//
//  TagListRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation
import AlloDomain

final class TagAddRespositoryImpl: TagAddRespository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func addTag(groupId: Int, tagName: String) async throws -> TagList {
        let dto = try await networkService.addTag(groupId, tagName: tagName)
        return TagList(tagId: dto.tagId, name: dto.tagName)
    }
}
