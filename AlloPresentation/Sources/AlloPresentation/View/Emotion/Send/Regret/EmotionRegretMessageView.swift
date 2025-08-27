//
//  EmotionRegretMessageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/21/25.
//

import SwiftUI

public struct EmotionRegretMessageView: View {
    @StateObject private var viewModel: EmotionRegretMessageViewModel
    @FocusState private var isTextEditorFocused: Bool
    @State private var contentText: String = ""
    @State private var showMainButton = false

    private let maxCharacters = 200
    
    public init(viewModel: EmotionRegretMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Navigation / Title
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton) })
            
            Text("아쉬운 마음을 남겨주세요.")
                .font(.headline4)
                .foregroundStyle(.gray900)
                .padding(.top, 10)
            
            // MARK: - 체크된 작업
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.houseworkTitle)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            
            // MARK: - 받는 사람
            HStack(spacing: 12) {
                AsyncImage(url: viewModel.state.receiverImg) { phase in
                    switch phase {
                    case .empty:
                        EmptyView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28)
                            .clipShape(Circle())
                    case .failure:
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
                Text("To. \(viewModel.state.receiverName)")
                    .font(.body1)
                    .foregroundStyle(.gray600)
            }
            .padding(.top, 30)
            .padding(.bottom, 10)
            ZStack(alignment: .topLeading) {
                if contentText.isEmpty {
                    Text("내용을 작성해주세요.")
                        .foregroundColor(.gray300)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                }
                
                TextEditor(text: Binding(
                    get: { viewModel.state.contentText },
                    set: { viewModel.action(.updateContentText($0)) }
                ))
                .focused($isTextEditorFocused)
                .frame(height: 290)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isTextEditorFocused ? .blue400 : .gray300, lineWidth: 2)
                )
                .onChange(of: isTextEditorFocused) { focused in
                    if !focused && !viewModel.state.contentText.isEmpty {
                        // 키보드 내려가고 내용이 있으면 버튼 노출
                        withAnimation { showMainButton = true }
                    } else {
                        // 입력 중이면 버튼 숨김
                        showMainButton = false
                    }
                }
                .font(.subtitle7)
                .foregroundColor(viewModel.state.isAITransformed ? .blue400 : .gray700)
                
                VStack {
                    Spacer()
                    HStack {
                        if viewModel.state.isAITransformed {
                            Button(action: {
                                viewModel.action(.didTapRotateButton)
                            }) {
                                Image(.iconRotate)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 24)
                                    .padding(.bottom, 10)
                            }
                        }
                        Spacer()
                        Text("\(viewModel.state.contentText.count)/\(maxCharacters)자")
                            .font(.caption)
                            .foregroundColor(.gray500)
                            .padding(.trailing, 24)
                            .padding(.bottom, 10)
                    }
                }
            }
            .frame(height: 290)
            // MARK: - AI 말투 버튼
            Button(action: {
                viewModel.action(.didTapAIToneButton)
            }) {
                if viewModel.state.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 20, height: 20)
                } else {
                    HStack(spacing: 4) {
                        
                        Image(.iconAI)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("AI 말투 다듬기")
                            .font(.button1)
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                    .frame(width: 120, height: 35)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 50).fill(.blue400)
                    )
                }
            }
            Spacer()
            if showMainButton {
                MainButton(
                    title: "작성 완료",
                    action: { viewModel.action(.didTapNextButton) },
                    style: .bottoomMain
                )
                .padding(.bottom, 16)
            }
        }
        .padding(.horizontal, 20)
    }
}
