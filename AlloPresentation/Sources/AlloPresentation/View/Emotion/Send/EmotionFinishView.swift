//
//  EmotionFinishView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI

public struct EmotionFinishView: View {
    @StateObject private var viewModel: EmotionFinishViewModel
    @State private var contentText: String = ""
    
    private let maxCharacters = 200
    
    public init(viewModel: EmotionFinishViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Navigation / Title
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton)})
            Text(viewModel.state.houseworkTitle)
                .font(.button3)
                .foregroundStyle(.blue400)
            Text("To. \(viewModel.state.receiverName)님께 마음을 보냈어요.")
                .font(.headline4)
                .foregroundStyle(.gray900)
                .padding(.top, 16)
            VStack(alignment: .center) {
                Image(.iconEmotionCat)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            .frame(maxWidth: .infinity)
            HStack(spacing: 5) {
                Image(.iconThank)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("고마운 마음")
                    .font(.body1)
                    .foregroundStyle(.gray900)
            }
            VStack(spacing: 8) {
                ForEach(viewModel.state.sendEmotion.compliments, id: \.self) { compliment in
                    Text(compliment)
                    .font(.body1)
                    .foregroundStyle(.gray900)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.gray25) // 배경색
                    .cornerRadius(12)
                }
            }
            .padding(.vertical, 16)
            HStack(spacing: 5) {
                Image(.iconRegret)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("아쉬운 마음")
                    .font(.body1)
                    .foregroundStyle(.gray900)
            }
            Spacer()
            MainButton(
                title: "마음함으로",
                action: { viewModel.action(.didTapSendButton)},
                style: .bottoomMain
            )
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
    }
}
