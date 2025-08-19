//
//  UnderlineTextFields.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/10/25.
//

import SwiftUI

struct UnderlineTextFields: View {
    let onPresetTap: () -> Void
    @State private var showError: Bool = false
    @Binding var text: String
    @FocusState private var isFocused: Bool
    private var underlineColor: Color {
        if text.isEmpty {
            return .gray400
        } else if showError {
            return .red700
        } else if isFocused {
            return .blue500
        } else {
            return .gray400
        }
    }
    
    public init(text: Binding<String>, onPresetTap: @escaping () -> Void, showError: Bool = false) {
        self._text = text
        self.onPresetTap = onPresetTap
        self._showError = State(initialValue: showError)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("집안일 입력")
                .font(.subtitle3)
                .foregroundColor(
                    showError
                    ? .red700
                    : (isFocused ? .blue500 : .gray500)
                )
                .focused($isFocused)

            HStack {
                TextField("집안일을 작성해주세요", text: $text)
                    .font(.subtitle3)
                    .focused($isFocused)
                    .padding(.vertical, 8)
                    .onChange(of: text) { _, newValue in
                        if newValue.count > 14 {
                            if !showError { showError = true }
                            text = String(newValue.prefix(14))
                        } else {
                            if newValue.count < 14 {
                                showError = false
                            }
                        }
                    }
                Button(action: onPresetTap) {
                    Image(.iconPreset)
                }
            }
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(underlineColor),
                alignment: .bottom
            )

            if showError {
                Text("14자 이내로 작성할 수 있어요.")
                    .font(.caption2)
                    .foregroundColor(.red700)
            }
        }
        .frame(height: 78)
    }
}
