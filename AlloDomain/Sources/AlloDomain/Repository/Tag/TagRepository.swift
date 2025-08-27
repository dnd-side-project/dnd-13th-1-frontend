//
//  TagRepository.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public protocol TagRepository: Sendable {
    func fetchTags() async throws -> [TagItem]
    func addTag(name: String) async throws -> TagItem
}


