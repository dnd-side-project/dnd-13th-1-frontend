//
//  ShareInviteCodeView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

public struct ShareInviteCodeView: View {
    
    @StateObject private var viewModel: ShareInviteCodeViewModel
    
    public init(viewModel: ShareInviteCodeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            TitleNavigationBar(
                title: "그룹 생성",
                onBack: {
                    viewModel.action(.didTapBackButton)
                }
            )
            .padding(.bottom, 20)
            TitleWithSubtitleView(
                title: "집안일을 할 멤버를 초대해주세요!",
                subtitle: "함께 집안일 일정을 계획하고 칭찬하고 기준을 조율해봐요.\n최대 5명까지 초대 할 수 있어요."
            )
            .padding(.bottom, 32)
            VStack(spacing: 10) {
                Text(viewModel.state.inviteCode)
                    .font(.headline3)
                    .foregroundStyle(.white)
                HStack(spacing: 10) {
                    Text("초대코드 복사하기")
                        .textSelection(.enabled)
                        .font(.subtitle6)
                        .foregroundStyle(.gray300)
                    Image(.iconCopy)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.gray700)
            .cornerRadius(.radius2)
            .onTapGesture {
                viewModel.action(.didTapCopyButton)
            }
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
    }
}
