//
//  StubTagRepository.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

struct StubTagRepository: TagRepository {
    func fetchTags() async throws -> [TagItem] { [TagItem(id: 1, name: "청소"), TagItem(id: 2, name: "정리")] }
    func addTag(name: String) async throws -> TagItem { TagItem(id: Int.random(in: 100...999), name: name) }
}


