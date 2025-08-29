//
//  GroupInfo.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct GroupInfo: Sendable {
    public let groupId: Int?
    public let inviteCode: String?
    public let groupType: GroupType?
    
    public init(groupId: Int? = nil, inviteCode: String? = nil, groupType: GroupType? = nil) {
        self.groupId = groupId
        self.inviteCode = inviteCode
        self.groupType = groupType
    }
}
