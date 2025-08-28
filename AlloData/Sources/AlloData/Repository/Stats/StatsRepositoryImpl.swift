//
//  StatsRepositoryImpl.swift
//  AlloData
//
//  Created by Assistant on 8/27/25.
//

import Foundation
import AlloDomain

final class StatsRepositoryImpl: StatsRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCleanliness() async throws -> CleanlinessScore {
        guard let groupId = UserDefaultsService.groupId else { return CleanlinessScore(cleanliness: 0) }
        let dto = try await networkService.getCleanliness(groupId)
        return CleanlinessScore(cleanliness: dto.cleanliness)
    }
    
    func fetchMyContribution() async throws -> ContributionScore {
        guard let groupId = UserDefaultsService.groupId else { return ContributionScore(contribution: 0) }
        let dto = try await networkService.getMyContribution(groupId)
        return ContributionScore(contribution: dto.contribution)
    }
    
    func fetchTodayCompletionStatus() async throws -> TodayCompletionStatus {
        let dto = try await networkService.getMyTodayCompletionStatus()
        return TodayCompletionStatus(completed: dto.completed, left: dto.left)
    }
    
    func fetchWeekCompletionStatus() async throws -> WeekCompletionStatus {
        let dto = try await networkService.getMyWeekCompletionStatus()
        let daily = WeekCompletionStatus.Daily(monday: dto.weeklyCompleted.monday, tuesday: dto.weeklyCompleted.tuesday, wednesday: dto.weeklyCompleted.wednesday, thursday: dto.weeklyCompleted.thursday, friday: dto.weeklyCompleted.friday, saturday: dto.weeklyCompleted.saturday, sunday: dto.weeklyCompleted.sunday)
        return WeekCompletionStatus(completed: dto.completed, total: dto.total, daily: daily)
    }
    
    func fetchTwoWeekComparison() async throws -> TwoWeekComparison {
        let dto = try await networkService.getMyTwoWeeksCompletionStatusComparison()
        return TwoWeekComparison(twoWeeksAgoCompleted: dto.twoWeeksAgoCompleted, lastWeekCompleted: dto.lastWeekCompleted)
    }
    
    func fetchActivitySummary() async throws -> ActivitySummary {
        let dto = try await networkService.getMyEmotionCardAndCompletionStatus()
        return ActivitySummary(received: dto.receivedEmotionCardCount, sent: dto.sentEmotionCardCount, completed: dto.completedHouseWorkCount)
    }
}


