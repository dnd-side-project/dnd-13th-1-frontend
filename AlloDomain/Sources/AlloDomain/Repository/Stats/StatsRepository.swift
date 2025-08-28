//
//  StatsRepository.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public protocol StatsRepository: Sendable {
    func fetchCleanliness() async throws -> CleanlinessScore
    func fetchMyContribution() async throws -> ContributionScore
    func fetchTodayCompletionStatus() async throws -> TodayCompletionStatus
    func fetchWeekCompletionStatus() async throws -> WeekCompletionStatus
    func fetchTwoWeekComparison() async throws -> TwoWeekComparison
    func fetchActivitySummary() async throws -> ActivitySummary
}


