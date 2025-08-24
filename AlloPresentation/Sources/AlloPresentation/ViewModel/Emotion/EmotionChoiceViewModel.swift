//
//  EmotionChoiceViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class EmotionChoiceViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var sendEmotion: SendEmotion
        var selectedHouseworkTitle: String
        var receiverName: String
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, selectedHouseworkTitle: houseworkTitle, receiverName: receiverName)
        self.state.selectedHouseworkTitle = houseworkTitle
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: "",
                compliments: ""
                )
            coordinator.push(AppScene.emotionThankMessage(sendEmotion: sendEmotion, receiverName: state.receiverName, houseworkTitle: state.selectedHouseworkTitle))
        }
    }
}
