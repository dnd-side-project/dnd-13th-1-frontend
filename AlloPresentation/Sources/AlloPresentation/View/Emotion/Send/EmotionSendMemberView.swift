//
//  EmotionSendMemberView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/21/25.
//

import SwiftUI
import AlloDomain

public struct EmotionSendMemberView: View {
    private let members: [Member] = []
    @State private var selectedMemberIDs: Set<Int> = []
    @StateObject private var viewModel: EmotionSendMemberViewModel
    public init(viewModel: EmotionSendMemberViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton)})
            Text("누구에게 보내는 마음인가요?")
                .font(.headline4)
                .foregroundStyle(.gray900)
            VStack(spacing: 12) {
                ForEach(viewModel.state.members, id: \.id) { member in
                    MemberButton(
                        member: member,
                        isSelected: selectedMemberIDs.contains(member.id),
                        action: { toggleSelection(for: member) },
                        displayName: member.id == 1 ? "나" : member.name
                    )
                }
            }
            .padding(.top, 32)
            Spacer()
            if !selectedMemberIDs.isEmpty {
                MainButton(
                    title: "다음으로",
                    action: { viewModel.action(.didTapNextButton)},
                    style: .bottoomMain
                )
                .padding(.bottom, 16)
            }
        }
        .padding(.horizontal, 20)
        .task {
            await viewModel.fetchMembers()
        }
    }
    private func toggleSelection(for member: Member) {
        selectedMemberIDs = [member.id]
        viewModel.state.selectedMembers = [member]
    }
}
