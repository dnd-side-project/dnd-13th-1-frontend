//
//  MypageMyWeeklyReportView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageMyWeeklyReportView: View {
    let dateString: String
    let completed: [Int]
    let total: Int
    let currentWeekString: String
    let pastWeekString: String
    let currentWeekCompletedCount: Int
    let pastWeekCompletedCount: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("MY 주간 레포트")
                .font(.subtitle1)
                .foregroundStyle(.black)
            MypageMyWeeklyReportChartView(
                dateString: dateString,
                completed: completed,
                total: total
            )
                .padding(.bottom, 2)
            MypageMyWeeklyReportChartComparisonView(
                currentWeekString: currentWeekString,
                pastWeekString: pastWeekString,
                currentWeekCompletedCount: currentWeekCompletedCount,
                pastWeekCompletedCount: pastWeekCompletedCount
            )
        }.frame(maxWidth: .infinity)
    }
}
