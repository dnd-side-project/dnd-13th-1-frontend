//
//  EmotionDetail.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

public final class EmotionDetail: Equatable, Identifiable, Sendable {
    /// Equatable을 채택하여 State의 변화를 보장합니다
    public static func == (lhs: EmotionDetail, rhs: EmotionDetail) -> Bool {
        lhs.id == rhs.id
    }
    // MARK: - Properties
    public let emotionCardId: Int
    public let houseworkName: String
    public let compliments: [String]
    public let disappointment: String
    public let senderNickName: String
    public let receiverNickName: String
    public let createdTime: String
    // MARK: - Initializer
    public init(emotionCardId: Int, houseworkName: String, compliments: [String], disappointment: String, senderNickName: String, receiverNickName: String, createdTime: String ) {
        self.emotionCardId = emotionCardId
        self.houseworkName = houseworkName
        self.compliments = compliments
        self.disappointment = disappointment
        self.senderNickName = senderNickName
        self.receiverNickName = receiverNickName
        self.createdTime = createdTime
    }
}
