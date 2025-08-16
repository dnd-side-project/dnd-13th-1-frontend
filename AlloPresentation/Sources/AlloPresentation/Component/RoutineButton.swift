//
//  RoutineButton.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/16/25.
//

import SwiftUI

struct RoutineButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button {
            action() // 클릭 시 전달된 액션 실행
        } label: {
            HStack(spacing: 12) {
                Image(isSelected ? .iconCheckOn : .iconCheckOff)
                    .resizable()
                    .frame(width: 22, height: 22)
                    .padding(.leading, 20)
                Text(title)
                    .font(.subtitle2)
                    .foregroundColor(.gray900)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)
    }
}
