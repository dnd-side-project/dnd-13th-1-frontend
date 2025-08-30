//
//  CheckListCell.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI
import AlloDomain
import Kingfisher

struct CheckListCell: View {
    let housework: Housework
    let isEditing: Bool
    let status: CheckListCellStatus
    let isMyHousework: Bool
    let onCheckButtonTap: (Housework) -> Void
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 0
        ) {
            if !isEditing {
                Button(
                    action: {
                        onCheckButtonTap(housework)
                    }, label: {
                        VStack {
                            switch status {
                            case .normal:
                                Image(.iconCheckCircle)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            case .selected:
                                Image(.iconCheckCircleChecked)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            case .completed:
                                Image(.iconCheckCircleCheckedGray)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .frame(width: 44, height: 56)
                        .padding(.trailing, 6)
                    }
                )
            }
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                HStack(
                    alignment: .center,
                    spacing: 6
                ) {
                    Text(housework.place)
                        .font(.button3)
                        .foregroundStyle(status.placeTextColor)
                        .padding(.horizontal, 8)
                        .frame(height: 20)
                        .background(status.placeBackgroundColor)
                        .cornerRadius(.radius3)
                    Text(housework.title)
                        .font(.subtitle6)
                        .foregroundStyle(status == .completed ? .gray500 : .gray900)
                    Spacer(minLength: 0)
                }
                HStack(
                    alignment: .center,
                    spacing: 2
                ) {
                    if isMyHousework {
                        ProfileImageView(
                            url: housework.member[0].profileImageUrl,
                            size: 20,
                            cornerRadius: 20
                        )
                    }
                    ForEach(housework.member.dropFirst()) { member in
                        ProfileImageView(
                            url: member.profileImageUrl,
                            size: 20,
                            cornerRadius: 20
                        )
                        .opacity(0.4)
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, isEditing ? 24 : 6)
        .frame(height: 84)
        .frame(maxWidth: .infinity)
        .background(status == .selected ? .blue50 : .white)
        .cornerRadius(.radius2)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadiusStyle.radius2.rawValue)
                .stroke(status == .selected ? .blue400 : .clear, lineWidth: 1)
                .padding(1)
        )
        .padding(.horizontal, 20)
    }
    /// 셀 상태를 기반으로 텍스트 색, 배경색을 정의합니다
    enum CheckListCellStatus {
        case normal
        case selected
        case completed
        /// 셀 전체 배경색
        var cellBackgroundColor: Color {
            switch self {
            case .normal:
                    .white
            case .selected:
                    .white
            case .completed:
                    .gray100
            }
        }
        /// 장소 텍스트 색
        var placeTextColor: Color {
            switch self {
            case .normal:
                    .blue400
            case .selected:
                    .blue400
            case .completed:
                    .gray500
            }
        }
        /// 장소 배경 색
        var placeBackgroundColor: Color {
            switch self {
            case .normal:
                    .blue50
            case .selected:
                    .blue50
            case .completed:
                    .gray200
            }
        }
        /// 체크 아이콘 이미지
        var checkIconImage: Image {
            switch self {
            case .normal:
                Image(.iconCheckCircle)
            case .selected:
                Image(.iconCheckCircleChecked)
            case .completed:
                Image(.iconCheckCircleCheckedGray)
            }
        }
    }
}
