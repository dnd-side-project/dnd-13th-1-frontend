//
//  EmotionRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public protocol EmotionRepository: Sendable {
    func sendHouseworkEmotion(sendEmotion: SendEmotion) async throws
    func getEmotionList(filter: String, sorted: String) async throws -> ([EmotionList])
    func emotionDetail(for id: Int) async throws -> EmotionDetail
   // func deleteEmotion() async throws -> EmotionDetail
}
