//
//  EmotionCard.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct EmotionCard: Identifiable, Sendable {
    public let id: Int
    public let houseWorkName: String
    public let content: String
    public let senderNickName: String
    public let receiverNickName: String
    public let createdAt: Date
    public let emotionType: String?
    public let isRead: Bool?
    
    public init(id: Int, houseWorkName: String, content: String, senderNickName: String, receiverNickName: String, createdAt: Date, emotionType: String? = nil, isRead: Bool? = nil) {
        self.id = id
        self.houseWorkName = houseWorkName
        self.content = content
        self.senderNickName = senderNickName
        self.receiverNickName = receiverNickName
        self.createdAt = createdAt
        self.emotionType = emotionType
        self.isRead = isRead
    }
}


