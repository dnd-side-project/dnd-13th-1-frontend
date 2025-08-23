//
//  StubEmotionListRepository.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

public struct StubEmotionListRepository: EmotionRepository {
    public init() {}
    public func sendHouseworkEmotion() async throws -> [SendEmotion] {
        return []
    }

    public func getEmotionList(filter: String, sorted: String) async throws -> [EmotionList] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return [
            EmotionList(
                id: 1,
                houseWorkName: "세면대 청소",
                content: "고맙네~머리카락이 없어서 좋구만",
                senderNickName: "이건회",
                receiverNickName: "김민솔",
                createdTime: formatter.date(from: "2025-08-23T11:10:00") ?? Date(),
                emotionType: "thank"
            ),
            EmotionList(
                id: 2,
                houseWorkName: "침구 청소",
                content: "넌 진짜 안되겠다",
                senderNickName: "이건회",
                receiverNickName: "황채웅",
                createdTime: formatter.date(from: "2025-08-23T11:10:00") ?? Date(),
                emotionType: "regretful"
            ),
            EmotionList(
                id: 3,
                houseWorkName: "바닥 청소",
                content: "너 청소 진짜 잘하구나",
                senderNickName: "이건회",
                receiverNickName: "황채웅",
                createdTime: formatter.date(from: "2025-08-22T11:10:00") ?? Date(),
                emotionType: "both"
            ),
            EmotionList(
                id: 4,
                houseWorkName: "바닥 청소",
                content: "너 청소 진짜 잘하구나",
                senderNickName: "이건회",
                receiverNickName: "황채웅",
                createdTime: formatter.date(from: "2025-08-21T11:10:00") ?? Date(),
                emotionType: "both"
            ),
            EmotionList(
                id: 5,
                houseWorkName: "바닥 청소",
                content: "너 청소 진짜 잘하구나",
                senderNickName: "이건회",
                receiverNickName: "황채웅",
                createdTime: formatter.date(from: "2025-08-19T11:10:00") ?? Date(),
                emotionType: "both"
            )
        ]
    }

}

