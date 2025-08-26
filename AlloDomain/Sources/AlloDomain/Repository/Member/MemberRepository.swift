//
//  MemberRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/21/25.
//

import Foundation

public protocol MemberRepository: Sendable {
    func getMemberList(groupId: Int) async throws -> [Member]
}
