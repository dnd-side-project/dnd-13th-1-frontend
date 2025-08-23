//
//  StandardButton.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/16/25.
//

import SwiftUI
import AlloDomain

struct StandardButton: View {
    let title: String
    let standard: HouseworkStandard?
    @Binding var isSelected: Bool // 클릭 여부 바인딩
    
    // 기존 HouseworkStandard 초기화자
    init(standard: HouseworkStandard, isSelected: Binding<Bool>) {
        self.title = standard.rawValue
        self.standard = standard
        self._isSelected = isSelected
    }

    // 커스텀 문자열 초기화자
    init(title: String, isSelected: Binding<Bool>) {
        self.title = title
        self.standard = nil
        self._isSelected = isSelected
    }
    var body: some View {
        Button(action: {
            isSelected.toggle() // 클릭 시 선택 토글
        }) {
            HStack {
                if isSelected {
                    Image(.iconCheck)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .font(.button3)
                    .foregroundColor(isSelected ? .blue400 : .gray600)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(isSelected ? Color.blue500 : Color.gray200, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
