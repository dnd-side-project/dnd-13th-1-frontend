//
//  MypageMyReportView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageMyReportView: View {
    
    let completed: Int
    let total: Int
    let contribution: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("MY 레포트")
                .font(.subtitle1)
                .foregroundStyle(.black)
            HStack(spacing: 13) {
                ReportCardView(
                    title: "오늘의 내 집안일",
                    icon: .iconCheckEmpty,
                    value: completed,
                    unit: "/\(total)",
                    total: total,
                    valueColor: .blue400,
                    unitColor: .gray300,
                    showProgressBar: false,
                    backgroundColor: .gray50
                )
                ReportCardView(
                    title: "나의 기여도",
                    icon: .iconClean,
                    value: contribution,
                    unit: "%",
                    valueColor: .blue400,
                    unitColor: .blue400,
                    showProgressBar: true,
                    progressValue: contribution > 0 ? contribution : 0,
                    backgroundColor: .gray50
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
}
