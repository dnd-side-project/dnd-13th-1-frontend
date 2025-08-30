//
//  MyPageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class MyPageViewModel: ViewModelable {
    struct State {
        // Profile
        var profileImageUrl: URL?
        var name: String
        // Header stats
        var totalCompliments: Int
        var sentCompliments: Int
        var totalCompletedHouseworks: Int
        // My report
        var todayCompleted: Int
        var todayTotal: Int
        var myContribution: Int // percentage 0~100
        // Weekly chart
        var weeklyDateString: String
        var weeklyDailyCompleted: [Int] // mon...sun
        var weeklyTotal: Int
        // Comparison chart
        var comparisonCurrentWeekString: String
        var comparisonPastWeekString: String
        var comparisonCurrentCompleted: Int
        var comparisonPastCompleted: Int
    }
    enum Action {
        case didTapSettingButton
    }
    // MARK: - Dependencies
    private let fetchMemberUseCase: FetchMemberUseCase
    private let getActivitySummaryUseCase: GetActivitySummaryUseCase
    private let getTodayCompletionStatusUseCase: GetTodayCompletionStatusUseCase
    private let getMyContributionUseCase: GetMyContributionUseCase
    private let getWeekCompletionStatusUseCase: GetWeekCompletionStatusUseCase
    private let getTwoWeekComparisonUseCase: GetTwoWeekComparisonUseCase
    private let logoutUseCase: LogoutUseCase
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    // MARK: - Initializer
    public init(
        fetchMemberUseCase: FetchMemberUseCase,
        getActivitySummaryUseCase: GetActivitySummaryUseCase,
        getTodayCompletionStatusUseCase: GetTodayCompletionStatusUseCase,
        getMyContributionUseCase: GetMyContributionUseCase,
        getWeekCompletionStatusUseCase: GetWeekCompletionStatusUseCase,
        getTwoWeekComparisonUseCase: GetTwoWeekComparisonUseCase,
        logoutUseCase: LogoutUseCase,
        coordinator: Coordinator
    ) {
        self.fetchMemberUseCase = fetchMemberUseCase
        self.getActivitySummaryUseCase = getActivitySummaryUseCase
        self.getTodayCompletionStatusUseCase = getTodayCompletionStatusUseCase
        self.getMyContributionUseCase = getMyContributionUseCase
        self.getWeekCompletionStatusUseCase = getWeekCompletionStatusUseCase
        self.getTwoWeekComparisonUseCase = getTwoWeekComparisonUseCase
        self.logoutUseCase = logoutUseCase
        self.coordinator = coordinator
        self.state = State(
            profileImageUrl: nil,
            name: "",
            totalCompliments: 0,
            sentCompliments: 0,
            totalCompletedHouseworks: 0,
            todayCompleted: 0,
            todayTotal: 0,
            myContribution: 0,
            weeklyDateString: Date().getWeekString(),
            weeklyDailyCompleted: Array(repeating: 0, count: 7),
            weeklyTotal: 0,
            comparisonCurrentWeekString: Date().adding(days: -7).getWeekString(),
            comparisonPastWeekString: Date().adding(days: -14).getWeekString(),
            comparisonCurrentCompleted: 0,
            comparisonPastCompleted: 0
        )
    }
    func action(_ action: Action) {
        switch action {
        case .didTapSettingButton:
            Task {
                do {
                    try await logoutUseCase.execute()
                } catch {
                    // Handle error if needed
                    print("Logout failed: \(error)")
                }
            }
        }
    }
}

// MARK: - Loading
extension MyPageViewModel {
    public func load() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadProfile() }
            group.addTask { await self.loadHeaderStats() }
            group.addTask { await self.loadTodayAndContribution() }
            group.addTask { await self.loadWeekly() }
            group.addTask { await self.loadComparison() }
        }
    }
    private func loadProfile() async {
        do {
            let members = try await fetchMemberUseCase.execute()
            // 임시: 첫 번째 멤버를 나로 간주
            if let me = members.first {
                state.name = me.name
                state.profileImageUrl = me.profileImageUrl
            }
        } catch {
            // Silent fail for draft
        }
    }
    private func loadHeaderStats() async {
        do {
            let summary = try await getActivitySummaryUseCase.execute()
            state.totalCompliments = summary.received
            state.sentCompliments = summary.sent
            state.totalCompletedHouseworks = summary.completed
        } catch {
        }
    }
    private func loadTodayAndContribution() async {
        async let todayStatusTask = getTodayCompletionStatusUseCase.execute()
        async let contributionTask = getMyContributionUseCase.execute()
        do {
            let todayStatus = try await todayStatusTask
            let contribution = try await contributionTask
            state.todayCompleted = todayStatus.completed
            state.todayTotal = todayStatus.completed + todayStatus.left
            state.myContribution = contribution.contribution
        } catch {
        }
    }
    private func loadWeekly() async {
        do {
            let weekly = try await getWeekCompletionStatusUseCase.execute()
            state.weeklyTotal = weekly.total
            state.weeklyDailyCompleted = [
                weekly.daily.monday,
                weekly.daily.tuesday,
                weekly.daily.wednesday,
                weekly.daily.thursday,
                weekly.daily.friday,
                weekly.daily.saturday,
                weekly.daily.sunday
            ]
            state.weeklyDateString = Date().getWeekString()
        } catch {
        }
    }
    private func loadComparison() async {
        do {
            let comp = try await getTwoWeekComparisonUseCase.execute()
            state.comparisonCurrentCompleted = comp.lastWeekCompleted
            state.comparisonPastCompleted = comp.twoWeeksAgoCompleted
            state.comparisonCurrentWeekString = Date().getWeekString()
            state.comparisonPastWeekString = Date().adding(days: -7).getWeekString()
        } catch {
        }
    }
}
