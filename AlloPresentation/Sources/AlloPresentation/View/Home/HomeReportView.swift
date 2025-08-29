//
//  HomeReportView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI

struct HomeReportView: View {
    
    let completed: Int
    let total: Int
    let cleanliness: Int
    
    var body: some View {
        HStack(spacing: 13) {
            ReportCardView(
                title: "오늘의 공동 집안일",
                icon: .iconCheckEmpty,
                value: completed,
                unit: "/\(total)",
                total: total,
                valueColor: .blue400,
                unitColor: .gray300,
                showProgressBar: false,
            )
            
            ReportCardView(
                title: "우리집 청결도",
                icon: .iconClean,
                value: cleanliness,
                unit: "%",
                valueColor: .blue400,
                unitColor: .blue400,
                showProgressBar: true,
                progressValue: cleanliness
            )
        }
        .padding(.horizontal, 20)
    }
}

extension HomeReportView {
    func getMessage(completed: Int, total: Int) -> String {
        if total == 0 {
            "오늘 집안일이 없어요!"
        } else if completed == 0 {
            "집안일을 완수해볼까요?"
        } else if completed < total {
            "잘하고 있어요!"
        } else {
            "집안일을 모두 끝냈어요!"
        }
    }
}
