//
//  EmotionDeleteUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/29/25.
//

import Foundation

final class EmotionDeleteUseCaseImpl {
    private let emotionRepository: EmotionRepository
    init(emotionRepository: EmotionRepository) {
        self.emotionRepository = emotionRepository
    }
}

extension EmotionDeleteUseCaseImpl: EmotionDeleteUseCase {
    func execute(_ emotion: Int) async throws {
        try await emotionRepository.deleteEmotion(emotion)
    }
}
