//
//  SelectGroupTypeView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI
import AlloDomain

public struct SelectGroupTypeView: View {
    
    @StateObject private var viewModel: SelectGroupTypeViewModel
    
    public init(viewModel: SelectGroupTypeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                title: "어떤 주거형태로 살고계신가요?",
                subtitle: "함께 집안일을 관리할 공간을 알려주시면\n맞춤형 분위기로 안내해드릴게요."
            )
            .padding(.bottom, 32)
            VStack(spacing: 12) {
                ForEach(GroupType.allCases, id: \.self) { type in
                    GroupTypeItemView(
                        isSelected: viewModel.state.selectedGroupType == type,
                        type: type
                    ).onTapGesture {
                        viewModel.action(.didSelectGroupType(type))
                    }
                }
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

struct GroupTypeItemView: View {
    let isSelected: Bool
    let type: GroupType
    var body: some View {
        Text(type.title)
            .font(.subtitle1)
            .foregroundStyle(isSelected ? .blue400 : .gray700)
            .frame(height: 76)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(isSelected ? .blue50 : .gray25)
            .cornerRadius(.radius2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected ? .blue400 : .clear,
                        lineWidth: 2
                    )
            )
    }
}

extension GroupType {
    var title: String {
        switch self {
        case .roommate:
            return "룸메와 함께 거주"
        case .family:
            return "가족과 함께 거주"
        case .lover:
            return "연인과 함께 거주"
        }
    }
}
