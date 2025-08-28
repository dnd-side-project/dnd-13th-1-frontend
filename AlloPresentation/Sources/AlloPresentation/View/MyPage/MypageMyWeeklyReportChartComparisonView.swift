//
//  MypageMyWeeklyReportChartComparisonView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageMyWeeklyReportChartComparisonView: View {
    let currentWeekString: String
    let pastWeekString: String
    let currentWeekCompletedCount: Int
    let pastWeekCompletedCount: Int
    var body: some View {
        VStack {
            if currentWeekCompletedCount > pastWeekCompletedCount {
                MypageReportTitleView(
                    dateString: currentWeekString,
                    title: "지난 주 대비\n\(currentWeekCompletedCount - pastWeekCompletedCount)개의 집안일을 더 해냈어요!"
                )
                .padding(.bottom, 24)
            } else if currentWeekCompletedCount == pastWeekCompletedCount {
                MypageReportTitleView(
                    dateString: currentWeekString,
                    title: "지난 주와 집안일을\n\(pastWeekCompletedCount)개 똑같이 해냈어요!"
                )
                .padding(.bottom, 24)
            } else {
                MypageReportTitleView(
                    dateString: currentWeekString,
                    title: "지난 주보다 \(pastWeekCompletedCount - currentWeekCompletedCount)개 적게 했지만,\n잠깐 쉬어가는 주였어요."
                )
                .padding(.bottom, 24)
            }
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { index in
                        Rectangle()
                            .foregroundStyle(.gray100)
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                        if index < 4 { Spacer() }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
                .padding(.bottom, 26)
                .frame(maxHeight: .infinity)
                HStack(alignment: .center) {
                    Spacer(minLength: 0)
                    BigChartColumn(
                        count: pastWeekCompletedCount,
                        max: max(pastWeekCompletedCount, currentWeekCompletedCount),
                        weekString: pastWeekString,
                        isCurrent: false
                    )
                    Spacer(minLength: 0)
                    BigChartColumn(
                        count: currentWeekCompletedCount,
                        max: max(pastWeekCompletedCount, currentWeekCompletedCount),
                        weekString: currentWeekString,
                        isCurrent: true
                    )
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 164)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.gray25)
        .cornerRadius(.radius2)
    }
}

struct BigChartColumn: View {
    let count: Int
    let max: Int
    let weekString: String
    let isCurrent: Bool
    var body: some View {
        VStack(spacing: 4) {
            Spacer(minLength: 0)
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: 65, height: max == count ? 140 : CGFloat(count)/CGFloat(max) * 140)
                    .foregroundStyle(
                        isCurrent
                        ? count == max ? .blue500 : .blue200
                        : .gray200
                    )
                    .cornerRadius(.radius2)
                Text("\(count)개")
                    .font(.body2)
                    .foregroundStyle(max == count ? .white : .gray700)
                    .padding(.top, 6)
            }
            Text(weekString)
                .font(.body3)
                .foregroundStyle(.gray900)
        }
        .frame(width: 65)
    }
}
