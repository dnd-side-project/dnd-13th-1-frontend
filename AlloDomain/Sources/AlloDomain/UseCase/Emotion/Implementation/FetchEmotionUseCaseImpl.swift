//
//  FetchEmotionUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

final class FetchEmotionUseCaseImpl {
    private let emotionRepository: EmotionRepository
    init(emotionRepository: EmotionRepository) {
        self.emotionRepository = emotionRepository
    }
}

extension FetchEmotionUseCaseImpl: FetchEmotionUseCase {
    public func execute(filter: String, sorted: String) async throws -> [EmotionList] {
        return try await emotionRepository.getEmotionList(filter: filter, sorted: sorted)
    }
}
