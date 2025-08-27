//
//  EmotionRepositoryImpl.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

final class EmotionRepositoryImpl: EmotionRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func sendEmotionCard(houseWorkId: Int, receiverId: Int, compliments: [String], disappointment: String?) async throws -> Int {
        let req = SendEmotionRequestDTO(receiverId: receiverId, houseWorkId: houseWorkId, disappointment: disappointment ?? "", compliments: compliments)
        let dto = try await networkService.sendEmotionCard(req)
        return dto.emotionCardId
    }
    
    func fetchEmotionCardDetail(id: Int) async throws -> EmotionCard {
        let dto = try await networkService.getEmotionCardDetail(id)
        let f = ISO8601DateFormatter(); f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = f.date(from: dto.createdTime) ?? Date()
        return EmotionCard(id: dto.emotionCardId, houseWorkName: dto.houseWorkName, content: (dto.compliments + [dto.disappointment]).joined(separator: ", "), senderNickName: dto.senderNickName, receiverNickName: dto.receiverNickName, createdAt: date)
    }
    
    func fetchEmotionCardList(filter: String, sorted: String) async throws -> [EmotionCard] {
        let dto = try await networkService.getEmotionCardList(filter: filter, sorted: sorted)
        return dto.compactMap { item in
            let f = ISO8601DateFormatter(); f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let date = f.date(from: item.createdTime) ?? Date()
            return EmotionCard(id: item.emotionCardId, houseWorkName: item.houseWorkName, content: item.content, senderNickName: item.senderNickName, receiverNickName: item.receiverNickName, createdAt: date, emotionType: item.emotionType, isRead: item.isRead)
        }
    }
}
