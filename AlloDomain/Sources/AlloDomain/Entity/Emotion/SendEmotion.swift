//
//  SendEmotion.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public final class SendEmotion: Equatable, Identifiable, Sendable {
    /// Equatable을 채택하여 State의 변화를 보장합니다
    public static func == (lhs: SendEmotion, rhs: SendEmotion) -> Bool {
        lhs.id == rhs.id
    }
    // MARK: - Properties
    public let receiverId: Int
    public let houseWorkId: Int
    public let disappointment: String
    public let compliments: String
    // MARK: - Initializer
    public init(receiverId: Int, houseWorkId: Int, disappointment: String, compliments: String) {
        self.receiverId = receiverId
        self.houseWorkId = houseWorkId
        self.disappointment = disappointment
        self.compliments = compliments
    }
}
