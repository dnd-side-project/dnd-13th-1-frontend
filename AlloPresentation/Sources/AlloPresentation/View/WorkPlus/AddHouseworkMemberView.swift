//
//  AddHouseworkMemberView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import AlloDomain
import Kingfisher

public struct AddHouseworkMemberView: View {
    @StateObject private var viewModel: AddHouseworkMemberViewModel
    public init(viewModel: AddHouseworkMemberViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    private let members: [Member] = []
    
    @State private var selectedMemberIDs: Set<Int> = []
    
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: {viewModel.action(.didTapBackButton)})
                .padding(.bottom, 20)
            Text("분담 멤버를 선택하세요.")
                .font(.headline4)
                .foregroundColor(.gray900)
            HStack {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.housework.title)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            .padding(.bottom, 32)
            VStack(spacing: 12) {
                ForEach(viewModel.state.members, id: \.id) { member in
                    MemberButton(
                        member: member,
                        isSelected: selectedMemberIDs.contains(member.id),
                        action: { toggleSelection(for: member) }
                    )
                }
            }
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton)},
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }
        .padding(.horizontal, 20)
        .task {
            await viewModel.fetchMembers()
        }
    }
    
    private func toggleSelection(for member: Member) {
        if selectedMemberIDs.contains(member.id) {
            selectedMemberIDs.remove(member.id)
            viewModel.toggleMember(member)
        } else {
            selectedMemberIDs.insert(member.id)
            viewModel.toggleMember(member)
        }
    }
    
}

struct MemberButton: View {
    let member: Member
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                KFImage(member.profileImageUrl)
                    .placeholder {
                        Color.gray200
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
                Text(member.name)
                    .font(isSelected ? .subtitle3: .subtitle4)
                    .foregroundColor(isSelected ? .blue400 : .gray900)
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .blue50 : .gray25)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue400 : .gray25, lineWidth: 2)
        )
    }
}
