//
//  EmotionChoiceView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

public struct EmotionChoiceView: View {
    @StateObject private var viewModel: EmotionChoiceViewModel
    public init(viewModel: EmotionChoiceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton)})
            Text("누구에게 보내는 마음인가요?")
                .font(.headline4)
                .foregroundColor(.gray900)
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.receiverName)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            // MARK: - 체크된 작업
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.selectedHouseworkTitle)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            VStack(spacing: 12) {
                SendEmotionButton(
                    title: "고마운 마음 전하기",
                    icon: .iconThank,
                    isSelected: viewModel.state.selectedEmotion == .thank
                ) {
                    viewModel.action(.selectEmotion(.thank))
                }
                SendEmotionButton(
                    title: "아쉬운 마음 전하기",
                    icon: .iconRegret,
                    isSelected: viewModel.state.selectedEmotion == .regret
                ) {
                    viewModel.action(.selectEmotion(.regret))
                }
                SendEmotionButton(
                    title: "두 마음 다 전하기",
                    icon: .iconBoth,
                    isSelected: viewModel.state.selectedEmotion == .both
                ) {
                    viewModel.action(.selectEmotion(.both))
                }
            }
            .padding(.top, 32)
            Spacer()
            if viewModel.state.selectedEmotion != nil {
                MainButton(
                    title: "다음으로",
                    action: { viewModel.action(.didTapNextButton)},
                    style: .bottoomMain
                )
                .padding(.bottom, 16)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SendEmotionButton: View {
    let title: String
    let icon: ImageResource
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text(title)
                    .font(.subtitle1)
                    .foregroundColor(isSelected ? .blue400 : .gray900)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 76)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .blue50 : .gray25)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? .blue400 : .gray25, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}
