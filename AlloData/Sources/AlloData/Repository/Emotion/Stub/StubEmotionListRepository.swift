//
//  StubEmotionListRepository.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

//import Foundation
//import AlloDomain
//
//public struct StubEmotionListRepository: EmotionRepository {
//    public func emotionDetail(for id: Int) async throws -> EmotionDetail {
//            let allDetails: [EmotionDetail] = [
//                EmotionDetail(
//                    emotionCardId: 1,
//                    houseworkName: "세면대 청소",
//                    compliments: ["정말 깔끔하게 잘했어요!"],
//                    disappointment: "수건 걸이는 닦지 않았어요.",
//                    senderNickName: "이건회",
//                    receiverNickName: "김민솔",
//                    createdTime: "2025-08-23T11:10:00"
//                ),
//                EmotionDetail(
//                    emotionCardId: 2,
//                    houseworkName: "침구 청소",
//                    compliments: ["침구를 잘 정리했어요!!", "머리카락이 안보이네요 ㅋㅋ"],
//                    disappointment: "넌 진짜 안되겠다",
//                    senderNickName: "이건회",
//                    receiverNickName: "황채웅",
//                    createdTime: "2025-08-23T10:30:00"
//                )
//                // 필요시 더 추가
//            ]
//
//            guard let detail = allDetails.first(where: { $0.emotionCardId == id }) else {
//                throw NSError(domain: "StubEmotionListRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "EmotionDetail not found"])
//            }
//            return detail
//        }
//    
//    
//    public init() {}
//    public func sendHouseworkEmotion() async throws -> SendEmotion {
//        return []
//    }
//
//    public func getEmotionList(filter: String, sorted: String) async throws -> [EmotionList] {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//        return [
//            EmotionList(
//                id: 1,
//                houseWorkName: "세면대 청소",
//                content: "고맙네~머리카락이 없어서 좋구만",
//                senderNickName: "이건회",
//                receiverNickName: "김민솔",
//                createdTime: formatter.date(from: "2025-08-23T11:10:00") ?? Date(),
//                emotionType: "thank"
//            ),
//            EmotionList(
//                id: 2,
//                houseWorkName: "침구 청소",
//                content: "넌 진짜 안되겠다",
//                senderNickName: "이건회",
//                receiverNickName: "황채웅",
//                createdTime: formatter.date(from: "2025-08-23T11:10:00") ?? Date(),
//                emotionType: "regretful"
//            ),
//            EmotionList(
//                id: 3,
//                houseWorkName: "바닥 청소",
//                content: "너 청소 진짜 잘하구나",
//                senderNickName: "이건회",
//                receiverNickName: "황채웅",
//                createdTime: formatter.date(from: "2025-08-22T11:10:00") ?? Date(),
//                emotionType: "both"
//            ),
//            EmotionList(
//                id: 4,
//                houseWorkName: "바닥 청소",
//                content: "너 청소 진짜 잘하구나",
//                senderNickName: "이건회",
//                receiverNickName: "황채웅",
//                createdTime: formatter.date(from: "2025-08-21T11:10:00") ?? Date(),
//                emotionType: "both"
//            ),
//            EmotionList(
//                id: 5,
//                houseWorkName: "바닥 청소",
//                content: "너 청소 진짜 잘하구나",
//                senderNickName: "이건회",
//                receiverNickName: "황채웅",
//                createdTime: formatter.date(from: "2025-08-19T11:10:00") ?? Date(),
//                emotionType: "both"
//            )
//        ]
//    }
//
//}
//
