//
//  AIUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/25/25.
//

import Foundation

final class AIUseCaseImpl {
    private let aiRepository: AIRepository
    init(aiRepository: AIRepository) {
        self.aiRepository = aiRepository
    }
}

extension AIUseCaseImpl: AIUseCase {
    func transformMessage(_ text: String) async throws -> String {
        try await aiRepository.transformText(text)
    }
}
