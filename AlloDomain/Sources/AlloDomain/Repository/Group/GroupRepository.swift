//
//  GroupRepository.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public protocol GroupRepository: Sendable {
    func createGroup(backGroundTypeNum: Int) async throws -> GroupInfo
    func enterGroup(inviteCode: String) async throws -> GroupInfo
    func getMyGroup() async throws -> GroupInfo
    func setMyGroup(groupId: Int)
}
