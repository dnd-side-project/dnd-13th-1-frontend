//
//  GetGroupStateRepositoryImpl.swift
//  AlloData
//
//  Created by Assistant on 8/30/25.
//

import Foundation
import AlloDomain
import Moya

final class GetGroupStateRepositoryImpl: GetGroupStateRepository {
    private let service: NetworkService
    
    init(networkService: NetworkService) {
        self.service = networkService
    }
    
    func getGroupState(groupId: Int) async throws -> GroupState {
        let response = try await service.getMyGroupState(groupId: groupId)
        return GroupState(
            cleanliness: response.cleanliness,
            state: response.state,
            message: response.message
        )
    }
}

