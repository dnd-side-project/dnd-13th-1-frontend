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
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    //ai usecase
    public init(coordinator: Coordinator, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworkTitle: houseworkTitle)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: state.sendEmotion.disappointment,
                compliments: state.sendEmotion.compliments
                )
            coordinator.push(AppScene.emotionFinish(sendEmotion: sendEmotion, receiverName: state.receiverName, houseworkTitle: state.houseworkTitle))
        }
    }
}
