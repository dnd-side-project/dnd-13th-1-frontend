//
//  Housework.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public final class Housework: Equatable, Identifiable, Sendable {
    public static func == (lhs: Housework, rhs: Housework) -> Bool {
        lhs.id == rhs.id
    }

    // 기존 필드
    public let id: Int
    public let place: String
    public let title: String
    public let member: [Member]
    public let date: Date
    public let isDone: Bool
    public let routine: HouseworkRoutine
    public let tags: [String]

    // 서버 전송용 필드
    public let houseWorkName: String
    public let placeAdd: Int
    public let tagsAdd: [Int]
    public let members: [Int]
    public let startDate: String
    public let dueDate: String
    public let routineAdd: Routine
    public let dayOfTheWeek: [AddDayOfTheWeek]
    public let isNotified: Bool

    // 기본 초기화자
    public init(
        id: Int,
        place: String,
        title: String,
        member: [Member],
        date: Date,
        isDone: Bool,
        routine: HouseworkRoutine,
        tags: [String],
        houseWorkName: String,
        placeAdd: Int,
        tagsAdd: [Int],
        members: [Int],
        startDate: String,
        dueDate: String,
        routineAdd: Routine,
        dayOfTheWeek: [AddDayOfTheWeek],
        isNotified: Bool
    ) {
        self.id = id
        self.place = place
        self.title = title
        self.member = member
        self.date = date
        self.isDone = isDone
        self.routine = routine
        self.tags = tags
        self.houseWorkName = houseWorkName
        self.placeAdd = placeAdd
        self.tagsAdd = tagsAdd
        self.members = members
        self.startDate = startDate
        self.dueDate = dueDate
        self.routineAdd = routineAdd
        self.dayOfTheWeek = dayOfTheWeek
        self.isNotified = isNotified
    }
    public convenience init(
        id: Int,
        place: String,
        title: String,
        member: [Member],
        date: Date,
        isDone: Bool,
        routine: HouseworkRoutine,
        tags: [String]
    ) {
        self.init(
            id: id,
            place: place,
            title: title,
            member: member,
            date: date,
            isDone: isDone,
            routine: routine,
            tags: tags,
            houseWorkName: title,
            placeAdd: 0,
            tagsAdd: [],
            members: [],
            startDate: "",
            dueDate: "",
            routineAdd: .none,
            dayOfTheWeek: [],
            isNotified: false
        )
    }

    // 서버 전송용 convenience 초기화자
    public convenience init(
        houseWorkName: String,
        placeAdd: Int,
        tagsAdd: [Int],
        members: [Int],
        startDate: String,
        dueDate: String,
        routineAdd: Routine,
        dayOfTheWeek: [AddDayOfTheWeek],
        isNotified: Bool
    ) {
        self.init(
            id: 0,
            place: "",
            title: houseWorkName,
            member: [],
            date: Date(),
            isDone: false,
            routine: .none,
            tags: [],
            houseWorkName: houseWorkName,
            placeAdd: placeAdd,
            tagsAdd: tagsAdd,
            members: members,
            startDate: startDate,
            dueDate: dueDate,
            routineAdd: routineAdd,
            dayOfTheWeek: dayOfTheWeek,
            isNotified: isNotified
        )
    }
}
public enum Routine: String, Codable, Sendable {
    case none = "NONE"
    case everyDay = "EVERY_DAY"
    case everyWeek = "EVERY_WEEK"
    case biWeek = "BI_WEEK"
}

public enum AddDayOfTheWeek: String, Codable, Sendable {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
}

