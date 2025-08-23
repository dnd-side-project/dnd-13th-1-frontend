//
//  EmotionThankMessageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI

public struct EmotionThankMessageView: View {
     @StateObject private var viewModel: EmotionThankMessageViewModel
    @State private var contentText: String = ""
    
    private let maxCharacters = 200
    
    public init(viewModel: EmotionThankMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Navigation / Title
            TitleNavigationBar(title: "", onBack: { print("") })
            
            Text("아쉬운 마음을 남겨주세요.")
                .font(.headline4)
                .foregroundStyle(.gray900)
                .padding(.top, 16)
            
            // MARK: - 체크된 작업
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("가스레인지랑 인덕션 주위 청소")
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            
            // MARK: - 받는 사람
            HStack(spacing: 8) {
                Image(.icEmotionUnselected) // 프로필 이미지
                    .resizable()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                Text("To. 유재석")
                    .font(.body1)
                    .foregroundStyle(.gray600)
            }
            .padding(.top, 50)
            
            ZStack(alignment: .topLeading) {
                if contentText.isEmpty {
                    Text("내용을 작성해주세요.")
                        .foregroundColor(.gray400)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                }
                
                TextEditor(text: $contentText)
                    .frame(height: 290)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray300, lineWidth: 1)
                    )
                    .font(.body1)
                HStack {
                    Spacer()
                    Text("\(contentText.count)/\(maxCharacters)자")
                        .font(.caption)
                        .foregroundColor(.gray500)
                }
            }
            
            // MARK: - 글자 수 / AI 말투 버튼
            HStack() {
                Spacer()
                Button(action: {
                   // viewModel.action(.aiToneAdjustDidTap)
                }) {
                    HStack(spacing: 4) {
                        Image(.iconAI) // AI 아이콘
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("AI 말투 다듬기")
                            .font(.button1)
                            .foregroundStyle(.white)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 50).fill(.blue400)
                )
            }
            .padding(.top, 20)
            Spacer()
            MainButton(
                title: "작성 완료",
                action: { print("") },
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }
        .padding(.horizontal, 20)
    }
}
