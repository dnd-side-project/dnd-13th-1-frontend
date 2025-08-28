//
//  HouseworkSevendays.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public final class HouseworkRecent: Codable, Sendable, Identifiable {
    public static func == (lhs: HouseworkRecent, rhs: HouseworkRecent) -> Bool {
        lhs.id == rhs.id
    }
    // MARK: - Properties
    public let id: Int
    public let place: String
    public let title: String
    // MARK: - Initializer
    public init(id: Int, place: String, title: String) {
        self.id = id
        self.place = place
        self.title = title
    }
}

public final class HouseworkSevendays: Codable, Sendable, Identifiable {
    public var id: String { date }
    public let date: String
    public let houseWorks: [HouseworkRecent]

    public init(date: String, houseWorks: [HouseworkRecent]) {
        self.date = date
        self.houseWorks = houseWorks
    }
}
