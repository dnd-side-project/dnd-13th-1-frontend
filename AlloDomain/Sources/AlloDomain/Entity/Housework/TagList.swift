//
//  TagList.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//
import Foundation

public final class TagList: Equatable, Identifiable, Hashable, Sendable {
    public let tagId: Int
    public let name: String
    
    public static func == (lhs: TagList, rhs: TagList) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(tagId)
    }
    
    public init(tagId: Int, name: String) {
        self.tagId = tagId
        self.name = name
    }
}
