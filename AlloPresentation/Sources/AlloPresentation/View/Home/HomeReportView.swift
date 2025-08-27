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
            VStack {
                // 텍스트
                HStack {
                    Text("오늘의 공동 집안일")
                        .font(.body3)
                        .foregroundStyle(.gray600)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(.iconCheckEmpty)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                // 숫자
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(completed)")
                        .font(.headline5)
                        .foregroundStyle(.blue400)
                    Text("/\(total)")
                        .font(.subtitle2)
                        .foregroundStyle(.gray300)
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                // 상태 메시지
                HStack {
                    Text("오늘 집안일이 없어요!")
                        .font(.body6)
                        .foregroundStyle(.gray800)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, 16)
            .background(.white)
            .frame(height: 124)
            .frame(maxWidth: .infinity)
            .cornerRadius(.radius2)
            .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 2)
            VStack {
                // 텍스트
                HStack {
                    Text("우리집 청결도")
                        .font(.body3)
                        .foregroundStyle(.gray600)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(.iconClean)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                // 숫자
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(cleanliness)")
                        .font(.headline5)
                        .foregroundStyle(.blue400)
                    Text("%")
                        .font(.subtitle2)
                        .foregroundStyle(.blue400)
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                // 프로그레스바
                ZStack {
                    GeometryReader { geo in
                        Rectangle()
                            .foregroundStyle(.gray50)
                            .frame(width: geo.size.width)
                            .frame(height: 13)
                            .cornerRadius(.radius3)
                        Rectangle()
                            .foregroundStyle(.blue400)
                            .frame(width: geo.size.width * CGFloat(cleanliness) / 100)
                            .frame(height: 13)
                            .cornerRadius(.radius3)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 14)
            .padding(.top, 14)
            .padding(.bottom, 16)
            .background(.white)
            .frame(height: 124)
            .frame(maxWidth: .infinity)
            .cornerRadius(.radius2)
            .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 2)
        }
        .padding(.horizontal, 20)
    }
}
