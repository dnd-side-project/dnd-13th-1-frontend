//
//  EmotionDetailUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

final class EmotionDetailUseCaseImpl {
    private let emotionDetailRepository: EmotionRepository
    init(emotionDetailRepository: EmotionRepository) {
        self.emotionDetailRepository = emotionDetailRepository
    }
}

extension EmotionDetailUseCaseImpl: EmotionDetailUseCase {
    public func execute(id: Int) async throws -> EmotionDetail {
        return try await emotionDetailRepository.emotionDetail(for: id)
    }
}
