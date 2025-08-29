//
//  AddHouseworkView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/15/25.
//

import Foundation
import SwiftUI
import AlloDomain

public struct AddHouseworkView: View {
    @StateObject var viewModel: AddHouseworkViewModel
    @FocusState private var isTextFieldFocused: Bool
    @State private var isAlarmOn: Bool = false
    public init(viewModel: AddHouseworkViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(spacing: 0) {
            TitleNavigationBar(title: "집안일 추가", onBack: {viewModel.action(.didTapBackButton)})
                .padding(.bottom, 20)
            VStack(spacing: 32) {
                UnderlineTextFields(
                    text: $viewModel.state.myHouseworkTitle,
                    onPresetTap: {
                        viewModel.action(.didTapAddHouseworkButton)
                    },
                    showError: false,
                )
                .focused($isTextFieldFocused)
                // 장소 선택
                UnderlineTextView(
                    onPresetTap: {
                        viewModel.action(.didTapAddPlaceButton)
                    },
                    title: "장소 선택",
                    style: .place,
                    value: $viewModel.state.place
                )
                // 루틴 설정
                UnderlineTextView(
                    onPresetTap: {
                        viewModel.action(.didTapAdddRoutineButton)
                    },
                    title: "루틴 설정",
                    style: .routine,
                    value: $viewModel.state.routineText
                )
                // 마감일 선택
                UnderlineTextView(
                    onPresetTap: {
                        viewModel.action(.didTapHouseworkDetail)
                    },
                    title: "마감일 선택",
                    style: .deadline,
                    value: .constant(routineDateText)
                )
                AlarmSettngView(toggleOn: $isAlarmOn)
            }
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton) },
                style: isFormValid ? .bottoomMain : .selectionNo
            )
            .disabled(!isFormValid)
            .padding(.bottom, 16)
            .contentShape(Rectangle())
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        .padding(.horizontal, 20)
    }
    private var routineDateText: String {
        if viewModel.state.routine == "반복안함" {
            return viewModel.state.endDate
        } else {
            return "\(viewModel.state.startDate) - \(viewModel.state.endDate)"
        }
    }
    
    private var isFormValid: Bool {
        !viewModel.state.myHouseworkTitle.isEmpty &&
        !viewModel.state.place.isEmpty &&
        !viewModel.state.routineText.isEmpty &&
        !viewModel.state.startDate.isEmpty &&
        !viewModel.state.endDate.isEmpty
    }
}
