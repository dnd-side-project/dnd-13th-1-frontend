//
//  HouseworkDetailSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/29/25.
//

import Foundation
import SwiftUI
import AlloDomain

public struct HouseworkDetailSheet: View {
    let coordinator: Coordinator
    @StateObject private var viewModel: HouseworkDetailViewModel
    
    public init(
        coordinator: Coordinator,
        viewModel: HouseworkDetailViewModel
    ) {
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.gray200)
                .frame(width: 40, height: 4)
                .padding(.top, 13)
            headerView
            topView
            contentView
            Spacer()
            bottomActionButtons
        }
        .onAppear {
            Task {
                await viewModel.loadHouseworkDetail(houseworkId: 2)
            }
        }
    }
    // MARK: - Header
    private var headerView: some View {
        ZStack {
            Text("집안일 정보")
                .font(.subtitle1)
                .foregroundColor(.gray900)
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            HStack {
                Spacer()
                Button(action: { viewModel.action(.didTapDeleteHousework) }) {
                    Text("삭제")
                        .font(.button2)
                        .foregroundColor(.white)
                        .frame(width: 52, height: 32)
                        .background(.gray700)
                        .cornerRadius(20)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Content
    private var topView: some View {
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
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Text("분담 멤버")
                .font(.subtitle6)
                .foregroundColor(.gray700)
                .padding(.top, 20)
                .padding(.bottom, 8)
            Text(viewModel.state.housework.member
                .map { $0.name }
                .joined(separator: ", ")
            )
            .font(.body3)
            .foregroundColor(.gray600)
            if !viewModel.state.housework.tags.isEmpty {
                Text("집안일 기준 태그")
                    .font(.subtitle6)
                    .foregroundColor(.gray700)
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                let tags = viewModel.state.housework.tags
                var rows: [[String]] {
                    stride(from: 0, to: tags.count, by: 2).map { start in
                        let end = min(start + 2, tags.count)
                        return Array(tags[start..<end])
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(rows, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { tag in
                                TagItemView(tag: tag)
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .padding(.horizontal, 20)
        
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray25)
        )
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        
    }
    
    // MARK: - Bottom Buttons
    private var bottomActionButtons: some View {
        HStack(spacing: 20) {
            Button(action:
                    { viewModel.action(.didTapSendEmotion)
            }) {
                VStack {
                    Image(.iconEmotionHeart)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("마음 보내기")
                        .font(.button2)
                }
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(RoundedRectangle(cornerRadius: 12).fill(.blue50))
            }
            
            Button(action: {
                // 편집 화면 이동
            }) {
                VStack {
                    Image(.iconEditBtn)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("편집하기")
                        .font(.button2)
                }
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(RoundedRectangle(cornerRadius: 12).fill(.blue50))
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}
