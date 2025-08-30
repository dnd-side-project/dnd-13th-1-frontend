//
//  GetGroupStateRepository.swift
//  AlloDomain
//
//  Created by Assistant on 8/30/25.
//

import Foundation

public protocol GetGroupStateRepository: Sendable {
    func getGroupState(groupId: Int) async throws -> GroupState
}

