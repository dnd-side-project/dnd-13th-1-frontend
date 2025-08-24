//
//  EmotionFinishViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionFinishViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var sendEmotion: SendEmotion
        var receiverName: String
        var houseworkTitle: String
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapSendButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    //usecase
    private let sendEmotionUseCase: SendEmotionUseCase
    public init(coordinator: Coordinator, sendEmotionUseCase: SendEmotionUseCase,sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String) {
        self.coordinator = coordinator
        self.sendEmotionUseCase = sendEmotionUseCase
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworkTitle: houseworkTitle)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.popToRoot()
        }
    }
}
