//
//  PatchMyProfileUseCase.swift
//  AlloDomain
//
//  Created by 자동생성 on 8/29/25.
//

import Foundation

public protocol PatchMyProfileUseCase: Sendable {
    func execute(nickname: String, imageData: Data) async throws
}

public struct PatchMyProfileUseCaseImpl: PatchMyProfileUseCase {
    private let memberRepository: MemberRepository
    
    public init(memberRepository: MemberRepository) {
        self.memberRepository = memberRepository
    }
    
    public func execute(nickname: String, imageData: Data) async throws {
        try await memberRepository.patchMyProfile(nickname: nickname, imageData: imageData)
    }
}


