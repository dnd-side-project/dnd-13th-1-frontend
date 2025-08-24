//
//  EmotionThankMessageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI

public struct EmotionThankMessageView: View {
    @StateObject private var viewModel: EmotionThankMessageViewModel
    @State private var contentText: String = ""
    private let maxCharacters = 30
    public init(viewModel: EmotionThankMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Navigation / Title
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton) })
            
            Text("고마운 마음을 선택해주세요.")
                .font(.headline4)
                .foregroundStyle(.gray900)
                .padding(.top, 16)
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
            // MARK: - 체크된 작업
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.houseworkTitle)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            .padding(.top, 5)
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton) },
                style: .bottoomMain
            )
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
    }
}
