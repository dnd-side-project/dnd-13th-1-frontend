//
//  OnboardingCompleteView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

public struct OnboardingCompleteView: View {
    
    @StateObject private var viewModel: OnboardingCompleteViewModel
    
    public init(viewModel: OnboardingCompleteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            TitleNavigationBar(
                title: "",
                onBack: {
                    viewModel.action(.didTapBackButton)
                }
            )
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            Text.withColoredWord(
                "\(viewModel.state.nickname)님!\n함께 집안일을 시작해볼까요?",
                target: viewModel.state.nickname,
                color: .blue500,
                defaultColor: .gray800
            )
            .font(.headline2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
            Image(.illustrationCatOnboarding)
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
            Spacer(minLength: 0)
            HStack(spacing: 13) {
                MainButton(
                    title: "그룹 생성",
                    action: {
                        viewModel.action(.didTapCreateGroupButton)
                    },
                    style: .mainLeft
                )
                MainButton(
                    title: "그룹 입장",
                    action: {
                        viewModel.action(.didTapEnterGroupButton)
                    },
                    style: .mainRight
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
