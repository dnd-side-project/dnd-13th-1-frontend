//
//  MemberRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/21/25.
//

import Foundation

public protocol MemberRepository: Sendable {
    func fetchMembers() async throws -> [Member]
    func patchMyProfile(nickname: String, imageData: Data) async throws
}
