//
//  FetchMemberUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/21/25.
//

import Foundation

public protocol FetchMemberUseCase: Sendable {
    func execute() async throws -> [Member]
}
