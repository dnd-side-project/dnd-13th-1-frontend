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

public enum Complements: String, CaseIterable {
    case oneThank = "매번 맡아줘서 정말 든든해!"
    case twoThank = "생각보다 훨씬 꼼꼼하게 해줘서 고마워 :)"
    case threeThank = "바쁜데도 신경 써줘서 고마워 🥹"
    case fourThank = "덕분에 집이 깔끔해서 너무 좋았어!"
    case fiveThank = "이런 부분까지 신경 써줘서 감동이야 😃"
    case sixThank = "역시 네가 하면 다르다 👍🏻"
    case sevenThank = "직접 입력"
}
