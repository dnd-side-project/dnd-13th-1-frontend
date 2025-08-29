//
//  StubGroupRepository.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

struct StubGroupRepository: GroupRepository {
    func createGroup(backGroundTypeNum: Int) async throws -> GroupInfo { GroupInfo(groupId: 999, inviteCode: "INVITE-XXXX") }
    func enterGroup(inviteCode: String) async throws -> GroupInfo { GroupInfo(groupId: 999) }
    func getMyGroup() async throws -> GroupInfo { GroupInfo(groupId: 999) }
    func setMyGroup(groupId: Int) {
        UserDefaultsService.groupId = groupId
    }
}
