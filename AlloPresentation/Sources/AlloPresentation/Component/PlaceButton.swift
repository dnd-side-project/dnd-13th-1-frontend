//
//  PlaceButton.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/13/25.
//

import SwiftUI
import AlloDomain

struct PlaceButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subtitle2)
                .foregroundColor(.gray700)
                .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                .padding(.leading, 20)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .blue50 : .gray50)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue400 : .gray50, lineWidth: 1)
        )
    }
}
