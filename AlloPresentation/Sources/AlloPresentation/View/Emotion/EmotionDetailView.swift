//
//  EmotionDetailView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/26/25.
//

import SwiftUI

public struct EmotionDetailView: View {
    @StateObject private var viewModel: EmotionDetailViewModel
    
    public init(viewModel: EmotionDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            TitleNavigationBar(title: viewModel.state.isReceived ? "받은 마음 확인" : "보낸 마음 확인", onBack: { viewModel.action(.didTapBackButton) })
                .padding(.horizontal, 20)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.state.emotionDetail.houseworkName)
                        .font(.button3)
                        .foregroundStyle(.blue400)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue50)
                        )
                        .padding(.top, 23)
                    (
                        Text("To. ")
                            .foregroundColor(.gray300)
                        +
                        Text("\(viewModel.state.emotionDetail.receiverNickName)")
                            .foregroundColor(.gray900)
                    )
                    .font(.headline4)
                    .padding(.top, 2)
                    
                    HStack {
                        Spacer()
                        Image(.iconEmotionCat)
                            .resizable()
                            .frame(width: 260, height: 253)
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        if !viewModel.state.emotionDetail.compliments.isEmpty {
                            HStack(spacing: 5) {
                                Image(.iconThank)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("고마운 마음")
                                    .font(.body1)
                                    .foregroundStyle(.gray900)
                            }
                            ForEach(viewModel.state.emotionDetail.compliments, id: \.self) { compliment in
                                Text(compliment)
                                    .font(.subtitle7)
                                    .foregroundStyle(.gray900)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.gray25)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        if !viewModel.state.emotionDetail.disappointment.isEmpty {
                            HStack(spacing: 5) {
                                Image(.iconRegret)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("아쉬운 마음")
                                    .font(.body1)
                                    .foregroundStyle(.gray900)
                            }
                            .padding(.top, 40)
                            
                            Text(viewModel.state.emotionDetail.disappointment)
                                .font(.subtitle7)
                                .foregroundStyle(.gray900)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.gray25)
                                .cornerRadius(12)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
                }
                .padding(.horizontal, 20)
                Button {
                    viewModel.action(.didTapDeleteButton)
                } label: {
                    HStack {
                        Image(.iconTrash)
                        Text("삭제하기")
                            .foregroundColor(.gray500)
                            .font(.subtitle6)
                    }
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
                .padding(.bottom, 32)
            }
            
        }
    }
}
