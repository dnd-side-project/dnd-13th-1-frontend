//
//  TypeInviteCodeView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

public struct TypeInviteCodeView: View {
    @StateObject private var viewModel: TypeInviteCodeViewModel
    @FocusState private var isCodeFocused: Bool
    
    public init(viewModel: TypeInviteCodeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack {
            TitleNavigationBar(
                title: "그룹 입장",
                onBack: {
                    viewModel.action(.didTapBackButton)
                }
            )
            .padding(.bottom, 20)
            TitleWithSubtitleView(
                title: "초대받은 코드를 넣어주세요!",
                subtitle: "초대받은 코드를 삽입하거나 방을 생성해주세요!"
            )
            .padding(.bottom, 32)
            TextField("", text: $viewModel.state.inputText)
                .font(.subtitle1)
                .foregroundStyle(.gray900)
                .focused($isCodeFocused)
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundStyle(.gray400)
            Spacer(minLength: 0)
            MainButton(
                title: "완료",
                action: {
                    viewModel.action(.didTapNextButton)
                },
                style: .bottoomMain
            )
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .contentShape(Rectangle())
        .onTapGesture { isCodeFocused = false }
        
    }
}
