//
//  Member.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public final class Member: Equatable, Identifiable, Sendable {
    /// Equatable을 채택하여 State의 변화를 보장합니다
    public static func == (lhs: Member, rhs: Member) -> Bool {
        lhs.id == rhs.id
    }
    // MARK: - Properties
    public let id: Int
    public let name: String
    public let profileImageUrl: URL
    // MARK: - Initializer
    public init(id: Int, name: String, profileImageUrl: URL) {
        self.id = id
        self.name = name
        self.profileImageUrl = profileImageUrl
    }
}
