//
//  HomeMemberView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/30/25.
//

import SwiftUI
import AlloDomain

public struct HomeMemberView: View {
    @StateObject var viewModel: HomeMemberViewModel
    
    public init(viewModel: HomeMemberViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            TitleNavigationBar(
                title: "멤버",
                onBack: {
                    viewModel.action(.backButtonTapped)
                }
            )
            .padding(.bottom, 8)
            VStack(spacing: 12) {
                ForEach(viewModel.state.members) { member in
                    MemberButton(
                        member: member,
                        isSelected: false,
                        action: {
                        },
                        displayName: displayName(for: member)
                    )
                }
                HStack(spacing: 12) {
                    Image(.iconPlus)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 56)
                .background(.gray25)
                .cornerRadius(.radius2)
                .onTapGesture {
                    viewModel.action(.memberAddButtonTapped)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .task {
            viewModel.action(.load)
        }
    }
}

extension HomeMemberView {
    private func displayName(for member: Member) -> String {
        if let first = viewModel.state.members.first, first.id == member.id {
            return "나"
        } else {
            return member.name
        }
    }
}
