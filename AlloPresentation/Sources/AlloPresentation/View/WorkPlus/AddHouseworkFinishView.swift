//
//  AddHouseworkFinishView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import Kingfisher
import AlloDomain

public struct AddHouseworkFinishView: View {
    @StateObject private var viewModel: AddHouseworkFinishViewModel
    public init(viewModel: AddHouseworkFinishViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Navigation Bar 고정
                TitleNavigationBar(
                    title: "",
                    onBack: { viewModel.action(.didTapBackButton) }
                )
                .padding(.bottom, 25)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                
                // 본문 영역
                VStack(spacing: 12) {
                    VStack(alignment: .center) {
                        OverlappingProfileImages(members: viewModel.state.housework.member)
                        Spacer()
                        Text(
                            (viewModel.state.housework.member.count == 1 &&
                             viewModel.state.housework.member.first?.id == viewModel.state.housework.member.first?.id)
                            ? "설정한 집안일을 체크리스트에 추가할게요"
                            : "집안일을 분담할 멤버에게\n알림을 보낼게요!"
                        )
                        .font(.headline4)
                        .foregroundColor(.gray900)
                        .multilineTextAlignment(.center)
                    }
                    .frame(height: 164)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    // 상세 정보 섹션
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(viewModel.state.housework.title)
                                .font(.subtitle1)
                                .foregroundColor(.gray800)
                                .padding(.top, 20)
                            
                            HStack {
                                Text("장소")
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                                Spacer()
                                Text(viewModel.state.housework.place)
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                            }
                            
                            HStack {
                                Text("루틴")
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                                Spacer()
                                Text(viewModel.state.housework.routine.rawValue)
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                            }
                            
                            HStack {
                                Text("마감일")
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                                Spacer()
                                Text(viewModel.state.housework.date.toKoreanDateString())
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.gray25)
                        )
                        
                        VStack(alignment: .leading) {
                            if !viewModel.state.housework.tags.isEmpty {
                                Text("집안일 기준 태그")
                                    .font(.subtitle6)
                                    .foregroundColor(.gray700)
                                    .padding(.bottom, 5)
                                
                                let tags = viewModel.state.housework.tags
                                var rows: [[String]] {
                                    stride(from: 0, to: tags.count, by: 2).map { start in
                                        let end = min(start + 2, tags.count)
                                        return Array(tags[start..<end])
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    ForEach(rows, id: \.self) { row in
                                        HStack(spacing: 12) {
                                            ForEach(row, id: \.self) { tag in
                                                TagItemView(tag: tag)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.leading, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray25)
                        )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 72) // 버튼 공간 확보
            }

            VStack {
                Spacer()
                MainButton(
                    title: "추가하기",
                    action: { viewModel.action(.didTapNextButton) },
                    style: .bottoomMain
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                .background(Color.white)
            }
        }
    }
}

struct OverlappingProfileImages: View {
    let members: [Member]
    
    var body: some View {
        HStack(spacing: -38) {
            ForEach(members, id: \.id) { member in
                ProfileImageView(
                    url: member.profileImageUrl,
                    size: 84,
                    cornerRadius: 34
                )
            }
        }
    }
}

struct TagItemView: View {
    let tag: String
    
    var body: some View {
        Text(tag)
            .font(.button2)
            .foregroundColor(.blue400)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.blue400, lineWidth: 1)
            )
            .frame(height: 28)
    }
}
