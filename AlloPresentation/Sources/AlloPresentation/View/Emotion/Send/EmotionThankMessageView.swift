//
//  EmotionThankMessageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

public struct EmotionThankMessageView: View {
    @StateObject private var viewModel: EmotionThankMessageViewModel
    @State private var contentText: String = ""
    private let maxCharacters = 30

    public init(viewModel: EmotionThankMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            // MARK: - 고정 네비게이션
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton) })
                .padding(.horizontal, 20)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("고마운 마음을 선택해주세요.")
                        .font(.headline4)
                        .foregroundStyle(.gray900)
                    
                    Text("최대 3개 선택")
                        .font(.body4)
                        .foregroundStyle(.gray600)
                    
                    HStack(spacing: 8) {
                        Image(.iconCheck)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(viewModel.state.receiverName)
                            .font(.subtitle6)
                            .foregroundColor(.gray500)
                    }
                    HStack(spacing: 8) {
                        Image(.iconCheck)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(viewModel.state.houseworkTitle)
                            .font(.subtitle6)
                            .foregroundColor(.gray500)
                    }
                    // MARK: - Compliments
                    VStack(spacing: 12) {
                        ForEach(Compliments.allCases.filter { $0 != .sevenThank }, id: \.self) { compliment in
                            ComplimentsButton(
                                title: compliment.rawValue,
                                isSelected: viewModel.state.selectedCompliments.contains(compliment)
                            ) {
                                viewModel.action(.selectCompliment(compliment))
                            }
                        }
                        
                        if viewModel.state.selectedCompliments.contains(.sevenThank) {
                            if viewModel.state.customCompliment.isEmpty {
                                ComplimentsInputButton(
                                    text: $viewModel.state.customCompliment,
                                    isSelected: true,
                                    maxCharacters: maxCharacters,
                                    action: {}
                                )
                            } else {
                                ComplimentsButton(
                                    title: viewModel.state.customCompliment,
                                    isSelected: true
                                ) {}
                            }
                        } else {
                            ComplimentsInputButton(
                                text: $viewModel.state.customCompliment,
                                isSelected: false,
                                maxCharacters: maxCharacters
                            ) {
                                viewModel.action(.selectCompliment(.sevenThank))
                            }
                        }
                    } .padding(.top, 32)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            
            // MARK: - 고정 버튼
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton) },
                style: .bottoomMain
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
}

// MARK: - 일반 칭찬 버튼
struct ComplimentsButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.subtitle7)
                    .foregroundColor(isSelected ? .blue400 : .gray700)
                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    .padding(.leading, 20)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .blue50 : .gray50)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue400 : .gray50, lineWidth: 2)
        )
    }
}

// MARK: - 직접 입력 버튼 / TextField
struct ComplimentsInputButton: View {
    @Binding var text: String
    let isSelected: Bool
    let maxCharacters: Int
    let action: () -> Void
    
    var body: some View {
        VStack {
            if isSelected {
                TextField("직접 입력", text: $text)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 20)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.blue400, lineWidth: 2)
                    )
                    .onChange(of: text) { newValue in
                        if newValue.count > maxCharacters {
                            text = String(newValue.prefix(maxCharacters))
                        }
                    }
            } else {
                Button(action: action) {
                    Text("직접 입력")
                        .font(.subtitle7)
                        .foregroundColor(.gray700)
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                        .padding(.leading, 20)
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray50)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray50, lineWidth: 2)
                )
            }
        }
    }
}
