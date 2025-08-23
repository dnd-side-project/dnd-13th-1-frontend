//
//  EmotionRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public protocol EmotionRepository: Sendable {
    func sendHouseworkEmotion() async throws -> [SendEmotion]
    func getEmotionList() async throws -> ([EmotionList])
}
