//
//  Housework.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public final class Housework: Equatable, Identifiable, Sendable {
    /// Equatable을 채택하여 State의 변화를 보장합니다
    public static func == (lhs: Housework, rhs: Housework) -> Bool {
        lhs.id == rhs.id
    }
    // MARK: - Properties
    public let id: Int
    public let place: String
    public let title: String
    public let member: [Member]
    public let date: Date
    public let isDone: Bool
    public let routine: HouseworkRoutine
    // MARK: - Initializer
    public init(id: Int, place: String, title: String, member: [Member], date: Date, isDone: Bool, routine: HouseworkRoutine) {
        self.id = id
        self.place = place
        self.title = title
        self.member = member
        self.date = date
        self.isDone = isDone
        self.routine = routine
    }
}
