//
//  UnderlineTextView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/11/25.
//

import SwiftUI

struct UnderlineTextView: View {
    let onPresetTap: () -> Void
    var title: String
    var style: Style
    @Binding var value: String
    enum Style {
        case place
        case deadline
        case routine
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subtitle3)
                .foregroundColor(.gray500)
            HStack {
                Text(value)
                    .font(.subtitle3)
                    .foregroundColor(.black)
                Spacer()
                Button(action: onPresetTap) {
                    Group {
                        switch style {
                        case .deadline:
                            Image(.iconDatepicker)
                                .resizable()
                                .frame(width: 28, height: 28)
                        default:
                            Image(.iconSheetDown)
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray400),
                alignment: .bottom
            )
        }
    }
}

extension DateFormatter {
    static let deadlineFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
