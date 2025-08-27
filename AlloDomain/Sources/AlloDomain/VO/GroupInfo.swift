//
//  GroupInfo.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct GroupInfo: Sendable {
    public let groupId: Int
    public let inviteCode: String?
    
    public init(groupId: Int, inviteCode: String? = nil) {
        self.groupId = groupId
        self.inviteCode = inviteCode
    }
}


