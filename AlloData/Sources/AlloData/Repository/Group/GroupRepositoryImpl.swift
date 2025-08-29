//
//  GroupRepositoryImpl.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

final class GroupRepositoryImpl: GroupRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func createGroup(backGroundTypeNum: Int) async throws -> GroupInfo {
        let dto = try await networkService.createGroup(backGroundTypeNum)
        return GroupInfo(groupId: dto.groupId, inviteCode: dto.inviteCode)
    }
    
    func enterGroup(inviteCode: String) async throws -> GroupInfo {
        let dto = try await networkService.enterGroup(inviteCode)
        return GroupInfo(groupId: dto.groupId)
    }
    
    func getMyGroup() async throws -> GroupInfo {
        let dto = try await networkService.getMyGroup()
        return GroupInfo(groupId: dto.groupId, inviteCode: dto.inviteCode)
    }
    
    func setMyGroup(groupId: Int) {
        UserDefaultsService.groupId = groupId
    }
}
