//
//  MyPageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct MyPageView: View {
    @StateObject private var viewModel: MyPageViewModel
    public init(viewModel: MyPageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(spacing: 0) {
            MypageNavigationBar(
                onTapBackButton: nil,
                onTapSettings: {
                    viewModel.action(.didTapSettingButton)
                }
            )
            .padding(.bottom, 20)
            ScrollView {
                VStack(spacing: 0) {
                    MypageProfileView(
                        profileImageUrl: viewModel.state.profileImageUrl ?? URL(string: "https://example.com/placeholder.png")!,
                        name: viewModel.state.name
                    )
                    .padding(.bottom, 28)
                    MypageStatsView(
                        totalCompliments: viewModel.state.totalCompliments,
                        sentCompliments: viewModel.state.sentCompliments,
                        totalCompletedHouseworks: viewModel.state.totalCompletedHouseworks
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    /// 구분선
                    Rectangle()
                        .foregroundStyle(.gray100)
                        .frame(maxWidth: .infinity)
                        .frame(height: 8)
                        .padding(.bottom, 24)
                    MypageMyReportView(
                        completed: viewModel.state.todayCompleted,
                        total: viewModel.state.todayTotal,
                        contribution: viewModel.state.myContribution
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    MypageMyWeeklyReportView(
                        dateString: viewModel.state.weeklyDateString,
                        completed: viewModel.state.weeklyDailyCompleted,
                        total: viewModel.state.weeklyTotal,
                        currentWeekString: viewModel.state.comparisonCurrentWeekString,
                        pastWeekString: viewModel.state.comparisonPastWeekString,
                        currentWeekCompletedCount: viewModel.state.comparisonCurrentCompleted,
                        pastWeekCompletedCount: viewModel.state.comparisonPastCompleted
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 160)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .scrollIndicators(.never)
        }.task { await viewModel.load() }
    }
}
