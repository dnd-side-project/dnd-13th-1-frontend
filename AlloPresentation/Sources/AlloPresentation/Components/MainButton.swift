//
//  MainButton.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/10/25.
//

import SwiftUI

struct MainButton: View {
    let title: String
    let action: () -> Void
    let style: MainButtonStyle
    enum MainButtonStyle {
        case bottoomMain
        case selectionYes
        case selectionNo
        case mainLeft
        case mainRight
    }
    var backgroundColor: Color {
        switch style {
        case .bottoomMain, .mainRight, .selectionYes:
                .BLUE_400
        case .mainLeft, .selectionNo:
                .GRAY_50
        }
    }
    var textColor: Color {
        switch style {
        case .bottoomMain, .mainRight, .selectionYes:
                .white
        case .mainLeft, .selectionNo:
                .BLUE_400
        }
    }
    var height: CGFloat = 56
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subtitle3)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: height)
        }
        .background(backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
}
