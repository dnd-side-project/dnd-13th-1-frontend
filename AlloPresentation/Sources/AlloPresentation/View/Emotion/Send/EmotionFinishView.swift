//
//  EmotionFinishView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI

public struct EmotionFinishView: View {
    @StateObject private var viewModel: EmotionFinishViewModel
    
    public init(viewModel: EmotionFinishViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.state.houseworkTitle)
                        .font(.button3)
                        .foregroundStyle(.blue400)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 1)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.blue50)
                        )
                        .padding(.top, 44)
                    (
                        Text("To. ")
                            .foregroundColor(.gray300)
                        +
                        Text("\(viewModel.state.receiverName)님께 마음을 보냈어요.")
                            .foregroundColor(.gray900)
                    )
                    .font(.headline4)
                    .padding(.top, 2)
                    
                    HStack {
                        Spacer()
                        Image(.iconEmotionCat)
                            .resizable()
                            .frame(width: 207, height: 201)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        if !viewModel.state.sendEmotion.compliments.isEmpty {
                            HStack(spacing: 5) {
                                Image(.iconThank)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("고마운 마음")
                                    .font(.body1)
                                    .foregroundStyle(.gray900)
                            }
                            ForEach(viewModel.state.sendEmotion.compliments, id: \.self) { compliment in
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
                        if !viewModel.state.sendEmotion.disappointment.isEmpty {
                            HStack(spacing: 5) {
                                Image(.iconRegret)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("아쉬운 마음")
                                    .font(.body1)
                                    .foregroundStyle(.gray900)
                            }
                            
                            Text(viewModel.state.sendEmotion.disappointment)
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
            }
            MainButton(
                title: "마음함으로",
                action: { viewModel.action(.didTapSendButton) },
                style: .bottoomMain
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}
