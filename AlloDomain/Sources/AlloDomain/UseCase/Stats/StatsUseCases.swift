import Foundation

public protocol GetCleanlinessUseCase { func execute() async throws -> CleanlinessScore }
public protocol GetMyContributionUseCase { func execute() async throws -> ContributionScore }
public protocol GetTodayCompletionStatusUseCase { func execute() async throws -> TodayCompletionStatus }
public protocol GetWeekCompletionStatusUseCase { func execute() async throws -> WeekCompletionStatus }
public protocol GetTwoWeekComparisonUseCase { func execute() async throws -> TwoWeekComparison }
public protocol GetActivitySummaryUseCase { func execute() async throws -> ActivitySummary }

final class GetCleanlinessUseCaseImpl: GetCleanlinessUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> CleanlinessScore { try await repo.fetchCleanliness() } }
final class GetMyContributionUseCaseImpl: GetMyContributionUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> ContributionScore { try await repo.fetchMyContribution() } }
final class GetTodayCompletionStatusUseCaseImpl: GetTodayCompletionStatusUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> TodayCompletionStatus { try await repo.fetchTodayCompletionStatus() } }
final class GetWeekCompletionStatusUseCaseImpl: GetWeekCompletionStatusUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> WeekCompletionStatus { try await repo.fetchWeekCompletionStatus() } }
final class GetTwoWeekComparisonUseCaseImpl: GetTwoWeekComparisonUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> TwoWeekComparison { try await repo.fetchTwoWeekComparison() } }
final class GetActivitySummaryUseCaseImpl: GetActivitySummaryUseCase { private let repo: StatsRepository; init(repo: StatsRepository){ self.repo = repo } ; func execute() async throws -> ActivitySummary { try await repo.fetchActivitySummary() } }


