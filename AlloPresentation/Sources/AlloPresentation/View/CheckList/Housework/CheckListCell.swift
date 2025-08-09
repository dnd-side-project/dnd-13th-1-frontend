//
//  CheckListCell.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI
import Kingfisher

struct CheckListCell: View {
    let houseWorkId: Int
    let isEditing: Bool
    let status: CheckListCellStatus
    let place: String
    let houseWorkTitle: String
    let myProfileImageUrl: URL?
    let membersProfileImageUrl: [URL]?
    let onCheckButtonTap: (Int) -> Void
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 0
        ) {
            if isEditing {
                Button(
                    action: {
                        onCheckButtonTap(houseWorkId)
                    }, label: {
                        VStack {
                            switch status {
                            case .normal, .hover:
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
                    Text(place)
                        .font(.button3)
                        .foregroundStyle(status.placeTextColor)
                        .frame(width: 37, height: 20)
                        .background(status.placeBackgroundColor)
                        .cornerRadius(.radius3)
                    Text(houseWorkTitle)
                        .font(.subtitle6)
                        .foregroundStyle(status == .completed ? .gray500 : .gray900)
                }
                HStack(
                    alignment: .center,
                    spacing: 2
                ) {
                    KFImage(myProfileImageUrl)
                        .resizable()
                        .frame(width: 20, height: 20)
                    if let membersProfileImageUrl {
                        ForEach(membersProfileImageUrl.indices, id: \.self) { index in
                            KFImage(membersProfileImageUrl[index])
                                .resizable()
                                .frame(width: 20, height: 20)
                                .opacity(0.36) // FIXME: 조정 필요
                        }
                    }
                }
            }
            .padding(.vertical, 14)
            .frame(height: 84)
            .frame(maxWidth: .infinity)
            .cornerRadius(.radius2)
        }
    }
    /// 셀 상태를 기반으로 텍스트 색, 배경색을 정의합니다
    enum CheckListCellStatus {
        case normal
        case hover // Editing 중 Selected 포함
        case selected
        case completed
        /// 셀 전체 배경색
        var cellBackgroundColor: Color {
            switch self {
            case .normal:
                .white
            case .hover:
                .blue50
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
            case .hover:
                .blue50
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
            case .hover:
                .white
            case .selected:
                .blue50
            case .completed:
                .gray200
            }
        }
        /// 체크 아이콘 이미지
        var checkIconImage: Image {
            switch self {
            case .normal, .hover:
                Image(.iconCheckCircle)
            case .selected:
                Image(.iconCheckCircleChecked)
            case .completed:
                Image(.iconCheckCircleCheckedGray)
            }
        }
    }
}
