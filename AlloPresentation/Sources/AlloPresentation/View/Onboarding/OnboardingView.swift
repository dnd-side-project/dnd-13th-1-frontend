//
//  OnboardingView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import SwiftUI

public struct OnboardingView: View {
    
    @StateObject private var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            TitleNavigationBar(
                title: "",
                onBack: {
                    viewModel.action(.didTapBackButton)
                }
            )
            .padding(.horizontal, 20)
            TabView(selection: $viewModel.state.currentPage) {
                GuideView(
                    title: "집안일, 혼자만\n반복하지 마세요",
                    highlightTitle: ["집안일"],
                    subtitle: "자주 부딪히는 집안일을 간편하게 나눠요.",
                    image: .illustrationOnboardingFirst
                )
                .tag(0)
                GuideView(
                    title: "AI를 사용하여 대신\n전하는 부드러운 피드백",
                    highlightTitle: ["AI"],
                    subtitle: "전달하기 어려운 마음을 AI를 통해 전달해요.",
                    image: .illustrationOnboardingSecond
                )
                .tag(1)
                GuideView(
                    title: "인정받는 성취,\n집안일 기준까지 한눈에",
                    highlightTitle: ["성취", "집안일 기준"],
                    subtitle: "기준을 정해 충돌을 줄이고 성취를 인정받아요.",
                    image: .illustrationOnboardingThird
                )
                .tag(2)
            }
            .frame(maxWidth: .infinity)
            .tabViewStyle(.page)
            .indexViewStyle(
                .page(
                    backgroundDisplayMode: .always
                )
            )
            .ignoresSafeArea(edges: .top)
            Spacer(minLength: 0)
            MainButton(
                title: "다음으로",
                action: {
                    viewModel.action(.didTapNextButton)
                },
                style: .bottoomMain
            )
            .padding(.bottom, 16)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct GuideView: View {
    let title: String
    let highlightTitle: [String]
    let subtitle: String
    let image: ImageResource
    public var body: some View {
        VStack(spacing: 0) {
            Text.withColoredWords(
                title,
                targets: highlightTitle,
                color: .blue500
            )
            .foregroundStyle(.gray900)
            .font(.headline2)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(.bottom, 8)
            .padding(.horizontal, 20)
            Text(subtitle)
                .lineLimit(.none)
                .font(.body4)
                .foregroundStyle(.gray600)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            Image(image)
                .resizable()
                .frame(maxWidth: .infinity)
                .scaledToFit()
        }
    }
}
