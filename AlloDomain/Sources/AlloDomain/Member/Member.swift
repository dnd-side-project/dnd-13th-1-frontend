//
//  Member.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public final class Member: Equatable, Identifiable {
    public static func == (lhs: Member, rhs: Member) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: Int
    public let name: String
    public let profileImageUrl: URL
    
    public init(id: Int, name: String, profileImageUrl: URL) {
        self.id = id
        self.name = name
        self.profileImageUrl = profileImageUrl
    }
}
