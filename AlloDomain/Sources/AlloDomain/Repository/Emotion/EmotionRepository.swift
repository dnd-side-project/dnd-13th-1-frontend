//
//  EmotionRepository.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public protocol EmotionRepository: Sendable {
    func sendEmotionCard(houseWorkId: Int, receiverId: Int, compliments: [String], disappointment: String?) async throws -> Int
    func fetchEmotionCardDetail(id: Int) async throws -> EmotionCard
    func fetchEmotionCardList(filter: String, sorted: String) async throws -> [EmotionCard]
}


