//
//  ReportCardView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct ReportCardView: View {
    let title: String
    let icon: ImageResource
    let value: Int
    let unit: String
    let valueColor: Color
    let unitColor: Color
    let showProgressBar: Bool
    let progressValue: Int?
    let statusMessage: String?
    let backgroundColor: Color
    
    init(
        title: String,
        icon: ImageResource,
        value: Int,
        unit: String,
        valueColor: Color = .blue400,
        unitColor: Color = .blue400,
        showProgressBar: Bool = false,
        progressValue: Int? = nil,
        statusMessage: String? = nil,
        backgroundColor: Color = .white
    ) {
        self.title = title
        self.icon = icon
        self.value = value
        self.unit = unit
        self.valueColor = valueColor
        self.unitColor = unitColor
        self.showProgressBar = showProgressBar
        self.progressValue = progressValue
        self.statusMessage = statusMessage
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        VStack {
            // 텍스트
            HStack {
                Text(title)
                    .font(.body3)
                    .foregroundStyle(.gray600)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(icon)
                    .resizable()
                    .frame(width: icon == .iconClean ? 20 : 24, height: icon == .iconClean ? 20 : 24)
            }
            
            // 숫자
            HStack(alignment: .bottom, spacing: 0) {
                Text("\(value)")
                    .font(.headline5)
                    .foregroundStyle(valueColor)
                Text(unit)
                    .font(.subtitle2)
                    .foregroundStyle(unitColor)
            }
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            // 프로그레스바 또는 상태 메시지
            if showProgressBar, let progressValue = progressValue {
                ZStack {
                    GeometryReader { geo in
                        Rectangle()
                            .foregroundStyle(.gray50)
                            .frame(width: geo.size.width)
                            .frame(height: 13)
                            .cornerRadius(.radius3)
                        Rectangle()
                            .foregroundStyle(.blue400)
                            .frame(width: geo.size.width * CGFloat(progressValue) / 100)
                            .frame(height: 13)
                            .cornerRadius(.radius3)
                    }
                }
                .frame(maxWidth: .infinity)
            } else if let statusMessage = statusMessage {
                HStack {
                    Text(statusMessage)
                        .font(.body6)
                        .foregroundStyle(.gray800)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .frame(height: 124)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(.radius2)
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 2)
    }
}
