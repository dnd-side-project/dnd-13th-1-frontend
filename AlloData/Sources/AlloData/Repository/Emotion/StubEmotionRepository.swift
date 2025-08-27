//
//  StubEmotionRepository.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

struct StubEmotionRepository: EmotionRepository {
    func sendEmotionCard(houseWorkId: Int, receiverId: Int, compliments: [String], disappointment: String?) async throws -> Int { 1234 }
    func fetchEmotionCardDetail(id: Int) async throws -> EmotionCard {
        EmotionCard(id: id, houseWorkName: "설거지", content: "수고했어!", senderNickName: "철수", receiverNickName: "영희", createdAt: Date(), emotionType: "LIKE", isRead: true)
    }
    func fetchEmotionCardList(filter: String, sorted: String) async throws -> [EmotionCard] {
        [EmotionCard(id: 1, houseWorkName: "청소", content: "잘했어", senderNickName: "철수", receiverNickName: "영희", createdAt: Date(), emotionType: "LIKE", isRead: false)]
    }
}


