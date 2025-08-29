//
//  EmotionRepositoryimpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class EmotionRepositoryimpl: EmotionRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getEmotionList(filter: String, sorted: String) async throws -> [EmotionList] {
        let responseDTO = try await networkService.getEmotionCardList(filter: filter, sorted: sorted)
        return responseDTO.compactMap { element -> EmotionList? in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone.current

            guard let date = formatter.date(from: element.createdTime) else {
                return nil
            }
            return EmotionList(
                id: element.emotionCardId,
                houseWorkName: element.houseWorkName,
                content: element.content,
                senderNickName: element.senderNickName,
                receiverNickName: element.receiverNickName,
                createdTime: date,
                emotionType: element.emotionType,
                isRead: element.isRead
            )
        }
    }

    func sendHouseworkEmotion(sendEmotion: SendEmotion) async throws {
        let request = SendEmotionRequestDTO(
            receiverId: sendEmotion.receiverId,
            houseWorkId: sendEmotion.houseWorkId,
            disappointment: sendEmotion.disappointment,
            compliments: sendEmotion.compliments
        )
        let response = try await networkService.sendEmotionCard(request)
    }

    func emotionDetail(for id: Int) async throws -> EmotionDetail {
        let responseDTO = try await networkService.getEmotionCardDetail(id)
        
        return EmotionDetail(
            emotionCardId: responseDTO.emotionCardId,
            houseworkName: responseDTO.houseWorkName,
            compliments: responseDTO.compliments,
            disappointment: responseDTO.disappointment,
            senderNickName: responseDTO.senderNickName,
            receiverNickName: responseDTO.receiverNickName,
            createdTime: responseDTO.createdTime
        )
    }

    func deleteEmotion(_ emotion: Int) async throws {
        try await networkService.deleteEmotion(emotion)
    }
}
