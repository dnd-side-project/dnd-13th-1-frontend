//
//  EmotionUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

final class EmotionUseCaseImpl {
    private let emotionRepository: EmotionRepository
    init(emotionRepository: EmotionRepository) {
        self.emotionRepository = emotionRepository
    }
}

extension EmotionUseCaseImpl: SendEmotionUseCase {
    public func execute(sendEmotion: SendEmotion) async throws {
        return try await emotionRepository.sendHouseworkEmotion(sendEmotion: sendEmotion)
    }
}
