//
//  EmotionList.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public final class EmotionList: Equatable, Identifiable, Sendable {
    // MARK: - Equatable
    public static func == (lhs: EmotionList, rhs: EmotionList) -> Bool {
        lhs.id == rhs.id
    }
    
    // MARK: - Properties
    public let id: Int
    public let houseWorkName: String
    public let content: String
    public let senderNickName: String
    public let receiverNickName: String
    public let createdTime: Date
    
    // MARK: - Initializer
    public init(
        id: Int,
        houseWorkName: String,
        content: String,
        senderNickName: String,
        receiverNickName: String,
        createdTime: Date
    ) {
        self.id = id
        self.houseWorkName = houseWorkName
        self.content = content
        self.senderNickName = senderNickName
        self.receiverNickName = receiverNickName
        self.createdTime = createdTime
    }
}

