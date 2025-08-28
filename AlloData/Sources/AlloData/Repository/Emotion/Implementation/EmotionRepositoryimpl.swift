//
//  EmotionRepositoryimpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class EmotionRepositoryimpl: EmotionRepository {
    // TODO: Service 의존성 추가
    func getEmotionList(filter: String, sorted: String) async throws -> [EmotionList] {
        return []
    }
    func sendHouseworkEmotion() async throws -> [SendEmotion] {
        return []
    }
    public func emotionDetail(for id: Int) async throws -> EmotionDetail {
            let allDetails: [EmotionDetail] = [
                EmotionDetail(
                    emotionCardId: 1,
                    houseworkName: "세면대 청소",
                    compliments: ["정말 깔끔하게 잘했어요!"],
                    disappointment: "수건 걸이는 닦지 않았어요.",
                    senderNickName: "이건회",
                    receiverNickName: "김민솔",
                    createdTime: "2025-08-23T11:10:00"
                ),
                EmotionDetail(
                    emotionCardId: 2,
                    houseworkName: "침구 청소",
                    compliments: ["침구를 잘 정리했어요!!", "머리카락이 안보이네요 ㅋㅋ"],
                    disappointment: "넌 진짜 안되겠다",
                    senderNickName: "이건회",
                    receiverNickName: "황채웅",
                    createdTime: "2025-08-23T10:30:00"
                )
            ]

            guard let detail = allDetails.first(where: { $0.emotionCardId == id }) else {
                throw NSError(domain: "StubEmotionListRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "EmotionDetail not found"])
            }
            return detail
        }
}
