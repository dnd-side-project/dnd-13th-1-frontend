//
//  MypageStatsView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageStatsView: View {
    
    let totalCompliments: Int
    let sentCompliments: Int
    let totalCompletedHouseworks: Int
    
    var body: some View {
        HStack(alignment: .center) {
            MypageStatsElementView(title: "총 받은 칭찬", count: totalCompliments)
            MypageStatsDividerView()
            MypageStatsElementView(title: "보낸 칭찬", count: sentCompliments)
            MypageStatsDividerView()
            MypageStatsElementView(title: "총 완수 집안일", count: totalCompletedHouseworks)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 86)
        .background(.blue50)
        .cornerRadius(.radius2)
    }
}

struct MypageStatsElementView: View {
    let title: String
    let count: Int
    var body: some View {
        VStack {
            Text(title)
                .font(.body3)
                .foregroundStyle(.gray700)
                .padding(.bottom, 4)
            Text("\(count)개")
                .font(.subtitle1)
                .foregroundStyle(.blue400)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 72, alignment: .center)
    }
}

struct MypageStatsDividerView: View {
    var body: some View {
        Rectangle()
            .frame(width: 1, height: 46)
            .foregroundColor(.gray200)
    }
}
