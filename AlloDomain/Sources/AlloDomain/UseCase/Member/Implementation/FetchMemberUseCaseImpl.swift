//
//  FetchMemberUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/21/25.
//

import Foundation

final class FetchMemberUseCaseImpl {
    private let memberRepository: MemberRepository
    init(memberRepository: MemberRepository) {
        self.memberRepository = memberRepository
    }
}

extension FetchMemberUseCaseImpl: FetchMemberUseCase {
    public func execute(groupId: Int) async throws -> [Member] {
        return try await memberRepository.getMemberList(groupId: groupId)
    }
}
