//
//  StubStatsRepository.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

struct StubStatsRepository: StatsRepository {
    func fetchCleanliness() async throws -> CleanlinessScore { CleanlinessScore(cleanliness: 80) }
    func fetchMyContribution() async throws -> ContributionScore { ContributionScore(contribution: 42) }
    func fetchTodayCompletionStatus() async throws -> TodayCompletionStatus { TodayCompletionStatus(completed: 2, left: 3) }
    func fetchWeekCompletionStatus() async throws -> WeekCompletionStatus { WeekCompletionStatus(completed: 10, total: 20, daily: .init(monday: 1, tuesday: 2, wednesday: 3, thursday: 1, friday: 2, saturday: 1, sunday: 0)) }
    func fetchTwoWeekComparison() async throws -> TwoWeekComparison { TwoWeekComparison(twoWeeksAgoCompleted: 7, lastWeekCompleted: 10) }
    func fetchActivitySummary() async throws -> ActivitySummary { ActivitySummary(received: 3, sent: 5, completed: 12) }
}


