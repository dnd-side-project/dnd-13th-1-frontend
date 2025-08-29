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
                ProfileImageView(
                    url: viewModel.state.receiverImg,
                    size: 32,
                    cornerRadius: 32
                )
                Text("To. \(viewModel.state.receiverName)")
                    .font(.body1)
                    .foregroundStyle(.gray600)
            }
            .padding(.top, 30)
            .padding(.bottom, 10)
            
            // MARK: - 내용 작성 TextEditor
            ZStack(alignment: .topLeading) {
                if viewModel.state.contentText.isEmpty {
                    Text("내용을 작성해주세요.")
                        .foregroundColor(.gray300)
                        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                }
                
                TextEditor(text: Binding(
                    get: { viewModel.state.contentText },
                    set: { newValue in
                        // 200자 제한 적용
                        if newValue.count <= maxCharacters {
                            viewModel.action(.updateContentText(newValue))
                        } else {
                            viewModel.action(.updateContentText(String(newValue.prefix(maxCharacters))))
                            viewModel.state.isAIToneTriggered = false
                        }
                        if !newValue.isEmpty {
                                    viewModel.state.isAIToneTriggered = false
                                }
                    }
                ))
                .focused($isTextEditorFocused)
                .frame(height: 290)
                .padding(.horizontal, 19)
                .padding(.top, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(
//                            (viewModel.state.contentText.count > maxCharacters || viewModel.state.isAIToneTriggered)
//                                ? Color.red
//                                : (isTextEditorFocused ? .blue400 : .gray300),
//                            lineWidth: 2
//                        )
                        .stroke(
                            viewModel.state.isAIToneTriggered
                            ? .red700
                                : (isTextEditorFocused ? .blue400 : .gray300),
                            lineWidth: 2
                        )
                )
                .onChange(of: isTextEditorFocused) { focused in
                    if !focused && !viewModel.state.contentText.isEmpty {
                        withAnimation { showMainButton = true }
                    } else {
                        showMainButton = false
                    }
                }
                .font(.subtitle7)
                .foregroundColor(viewModel.state.isAITransformed ? .blue400 : .gray700)
                
                VStack {
                    Spacer()
                    HStack {
                        if viewModel.state.isAITransformed {
                            Button(action: { viewModel.action(.didTapRotateButton) }) {
                                Image(.iconRotate)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.leading, 24)
                                    .padding(.bottom, 10)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("\(viewModel.state.contentText.count)/\(maxCharacters)자")
                                .font(.caption)
                                .foregroundColor(.gray500)
                            if viewModel.state.contentText.count > maxCharacters {
                                Text("띄어쓰기 포함 총 200자 이내로 작성할 수 있습니다.")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 10)
                    }
                }
            }
            .frame(height: 290)
            HStack {
                Spacer()
                Button(action: { viewModel.action(.didTapAIToneButton) }) {
                    if viewModel.state.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 20, height: 20)
                    } else {
                        Image(.iconAI)
                            .resizable()
                            .frame(width: 133, height: 45)
                            .padding(.top, 23)
                    }
                }
            }
            
            Spacer()
            
            // MARK: - 작성 완료 버튼
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
        .onTapGesture { isTextEditorFocused = false }
    }
}
