//
//  Housework.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public final class Housework: Equatable, Identifiable {
    public static func == (lhs: Housework, rhs: Housework) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: Int
    public let place: String
    public let title: String
    public let member: [Member]
    public let date: Date
    public var isDone: Bool
    
    public init(id: Int, place: String, title: String, member: [Member], date: Date, isDone: Bool) {
        self.id = id
        self.place = place
        self.title = title
        self.member = member
        self.date = date
        self.isDone = isDone
    }
}
