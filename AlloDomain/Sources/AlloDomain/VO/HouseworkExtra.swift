//
//  HouseworkExtra.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct HouseworkDetail: Sendable {
    public let id: Int
    public let title: String
    public let placeName: String
    public let tags: [String]
    public let date: Date
    public let members: [Member]
    
    public init(id: Int, title: String, placeName: String, tags: [String], date: Date, members: [Member]) {
        self.id = id
        self.title = title
        self.placeName = placeName
        self.tags = tags
        self.date = date
        self.members = members
    }
}

public struct RecentHouseworkDay: Sendable {
    public let date: Date
    public let items: [RecentHouseworkItem]
    
    public init(date: Date, items: [RecentHouseworkItem]) {
        self.date = date
        self.items = items
    }
}

public struct RecentHouseworkItem: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let placeName: String
    public init(id: Int, name: String, placeName: String) {
        self.id = id
        self.name = name
        self.placeName = placeName
    }
}

public struct TodayPlaceHousework: Sendable {
    public let my: [TodayHouseworkItem]
    public let our: [TodayHouseworkItem]
    public init(my: [TodayHouseworkItem], our: [TodayHouseworkItem]) {
        self.my = my
        self.our = our
    }
}

public struct TodayHouseworkItem: Identifiable, Sendable {
    public let id: Int
    public let title: String
    public let memberProfileImageUrls: [URL]
    public init(id: Int, title: String, memberProfileImageUrls: [URL]) {
        self.id = id
        self.title = title
        self.memberProfileImageUrls = memberProfileImageUrls
    }
}

public struct PresetHouseworkCategory: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let houseworks: [PresetHousework]
    public init(id: Int, name: String, houseworks: [PresetHousework]) {
        self.id = id
        self.name = name
        self.houseworks = houseworks
    }
}

public struct PresetHousework: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


