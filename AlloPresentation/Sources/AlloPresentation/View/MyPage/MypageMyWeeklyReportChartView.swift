//
//  MypageMyWeeklyReportChartView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI
import AlloDomain

struct MypageMyWeeklyReportChartView: View {
    let dateString: String
    let completed: [Int]
    let total: Int
    
    private var totalCompleted: Int {
        return completed.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            MypageReportTitleView(
                dateString: dateString,
                title: "일주일 동안 \(total)개의 할 일 중\n\(totalCompleted)개를 완수했어요!"
            )
            .padding(.bottom, 24)
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
                .padding(.top, 41)
                .padding(.bottom, 29)
                .frame(maxHeight: .infinity)
                HStack(alignment: .bottom, spacing: 0) {
                    let safeMax = max(completed.max() ?? 0, 1)
                    ForEach(0..<completed.count, id: \.self) { index in
                        ChartColumnView(
                            count: completed[index],
                            max: safeMax,
                            dayOfTheWeek: DayOfTheWeek.allCases[index].rawValue
                        )
                        .frame(maxWidth: .infinity)
                    }
                }.frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.gray25)
        .cornerRadius(.radius2)
    }
}

struct ChartColumnView: View {
    let count: Int
    let max: Int
    let dayOfTheWeek: String
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(count)")
                .font(.caption3)
                .foregroundColor(count == max ? .blue400 : .gray300)
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 16, height: 140)
                    .foregroundColor(.gray100)
                    .cornerRadius(.radius3)
                Rectangle()
                    .frame(width: 16, height: (max > 0 ? CGFloat(Double(count) / Double(max)) * 140 : 0))
                    .foregroundColor(.blue600)
                    .cornerRadius(.radius3)
            }
            .padding(.bottom, 4)
            Text(dayOfTheWeek)
                .font(.subtitle6)
                .foregroundColor(.gray700)
        }
    }
}
