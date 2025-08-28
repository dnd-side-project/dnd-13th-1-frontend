//
//  Stats.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct CleanlinessScore: Sendable {
    public let cleanliness: Int
    public init(cleanliness: Int) { self.cleanliness = cleanliness }
}
public struct ContributionScore: Sendable {
    public let contribution: Int
    public init(contribution: Int) { self.contribution = contribution }
}
public struct TodayCompletionStatus: Sendable {
    public let completed: Int; public let left: Int
    public init(completed: Int, left: Int) { self.completed = completed; self.left = left }
}
public struct WeekCompletionStatus: Sendable {
    public struct Daily: Sendable {
        public let monday: Int; public let tuesday: Int; public let wednesday: Int; public let thursday: Int; public let friday: Int; public let saturday: Int; public let sunday: Int
        public init(monday: Int, tuesday: Int, wednesday: Int, thursday: Int, friday: Int, saturday: Int, sunday: Int) {
            self.monday = monday; self.tuesday = tuesday; self.wednesday = wednesday; self.thursday = thursday; self.friday = friday; self.saturday = saturday; self.sunday = sunday
        }
    }
    public let completed: Int
    public let total: Int
    public let daily: Daily
    public init(completed: Int, total: Int, daily: Daily) { self.completed = completed; self.total = total; self.daily = daily }
}
public struct TwoWeekComparison: Sendable { public let twoWeeksAgoCompleted: Int; public let lastWeekCompleted: Int; public init(twoWeeksAgoCompleted: Int, lastWeekCompleted: Int) { self.twoWeeksAgoCompleted = twoWeeksAgoCompleted; self.lastWeekCompleted = lastWeekCompleted } }
public struct ActivitySummary: Sendable { public let received: Int; public let sent: Int; public let completed: Int; public init(received: Int, sent: Int, completed: Int) { self.received = received; self.sent = sent; self.completed = completed } }


