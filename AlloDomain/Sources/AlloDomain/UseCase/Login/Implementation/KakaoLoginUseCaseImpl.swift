//
//  KakaoLoginUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation

final class KakaoLoginUseCaseImpl: KakaoLoginUseCase {
    private let repository: KakaoLoginRepository
    
    init(repository: KakaoLoginRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> Token {
        try await repository.kakaoLogin()
    }
}
