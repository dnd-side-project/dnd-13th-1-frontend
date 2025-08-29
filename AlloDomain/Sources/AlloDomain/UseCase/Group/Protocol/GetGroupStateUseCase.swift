//
//  GetGroupStateUseCase.swift
//  AlloDomain
//
//  Created by Assistant on 8/30/25.
//

import Foundation

public protocol GetGroupStateUseCase: Sendable {
    func execute(groupId: Int) async throws -> GroupState
}

public final class GetGroupStateUseCaseImpl: GetGroupStateUseCase {
    private let repository: GetGroupStateRepository
    
    public init(repository: GetGroupStateRepository) {
        self.repository = repository
    }
    
    public func execute(groupId: Int) async throws -> GroupState {
        return try await repository.getGroupState(groupId: groupId)
    }
}
