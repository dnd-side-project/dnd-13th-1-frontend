//
//  ProfileSettingView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import SwiftUI
import PhotosUI

public struct ProfileSettingView: View {
    
    @StateObject private var viewModel: ProfileSettingViewModel
    @FocusState private var isNicknameFocused: Bool
    
    public init(viewModel: ProfileSettingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State var inputText: String = ""
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TitleNavigationBar(
                title: "",
                onBack: {
                    viewModel.action(.didTapBackButton)
                }
            )
            TitleWithSubtitleView(
                title: "프로필을 설정해주세요!",
                subtitle: "그룹에서 사용할 내 프로필 이미지를 올릴 수 있어요"
            )
            .padding(.top, 8)
            .padding(.bottom, 32)
            ZStack(alignment: .bottomTrailing) {
                ProfileImageView(
                    url: nil,
                    uiImage: viewModel.state.profileUIImage,
                    size: 120,
                    cornerRadius: 48
                )
                Image(.iconCamera)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 4)
                    .padding(.bottom, 4)
            }
            .onTapGesture {
                viewModel.action(.didTapImageButton)
            }
            .photosPicker(isPresented: $viewModel.state.isPresentingPhotoPicker, selection: $viewModel.state.photoSelection, matching: .images)
            .padding(.bottom, 32)
            Text("닉네임")
                .font(.subtitle3)
                .foregroundStyle(.gray500)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField("영문, 한글, 숫자 10자 이하로 입력해주세요.", text: $viewModel.state.nickname)
                .font(.subtitle1)
                .foregroundStyle(.gray900)
                .focused($isNicknameFocused)
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundStyle(.gray400)
            Spacer(minLength: 0)
            HStack(spacing: 13) {
                MainButton(
                    title: "이전",
                    action: {
                        viewModel.action(.didTapBackButton)
                    },
                    style: .selectionNo
                )
                MainButton(
                    title: "다음으로",
                    action: {
                    viewModel.action(.didTapNextButton)
                    },
                    style: .selectionYes
                )
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .onTapGesture { isNicknameFocused = false }
        .task(id: viewModel.state.photoSelection) {
            await viewModel.loadSelectedPhoto()
        }
    }
}
