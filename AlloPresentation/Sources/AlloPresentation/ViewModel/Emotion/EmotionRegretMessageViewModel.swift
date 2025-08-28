//
//  EmotionRegretMessageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/21/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionRegretMessageViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var sendEmotion: SendEmotion
        var receiverName: String
        var houseworkTitle: String
        var contentText: String = ""
        var isLoading: Bool = false
        var isAITransformed: Bool = false
        var receiverImg: URL?
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
        case didTapAIToneButton
        case didTapRotateButton
        case updateContentText(String)
    }
    // MARK: - Properties
    var state: State
    let aiUseCase: AIUseCase
    let coordinator: Coordinator
    public init(coordinator: Coordinator, aiUseCase: AIUseCase, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, receiverImg: URL?) {
        self.coordinator = coordinator
        self.aiUseCase = aiUseCase
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworkTitle: houseworkTitle, receiverImg: receiverImg)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: state.contentText,
                compliments: state.sendEmotion.compliments
                )
            coordinator.push(AppScene.emotionFinish(sendEmotion: sendEmotion, receiverName: state.receiverName, houseworkTitle: state.houseworkTitle))
            
        case .didTapAIToneButton, .didTapRotateButton:
            Task { await transformTextWithAI() }
        case .updateContentText(let text):
            state.contentText = text
            state.isAITransformed = false
        }
    }
    
    private func transformTextWithAI() async {
        guard !state.contentText.isEmpty else { return }
        state.isLoading = true
        do {
            let transformed = try await aiUseCase.transformMessage(state.contentText)
            state.contentText = transformed
        } catch {
            print("AI 변환 실패: \(error.localizedDescription)")
        }
        state.isLoading = false
    }
}
