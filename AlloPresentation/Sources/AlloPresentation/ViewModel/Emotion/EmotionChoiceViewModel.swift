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
        var selectedEmotion: EmotionType? = nil
        var receiverImg: URL?
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
        case selectEmotion(EmotionType)
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, receiverImg: URL?) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, selectedHouseworkTitle: houseworkTitle, receiverName: receiverName, receiverImg: receiverImg)
        self.state.selectedHouseworkTitle = houseworkTitle
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            guard let selectedEmotion = state.selectedEmotion else { return }
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: "",
                compliments: []
            )
            switch selectedEmotion {
            case .thank, .both:
                coordinator.push(
                    AppScene.emotionThankMessage(
                        sendEmotion: sendEmotion,
                        receiverName: state.receiverName,
                        houseworkTitle: state.selectedHouseworkTitle,
                        initialEmotion: selectedEmotion,
                        receiverImg: state.receiverImg
                    )
                )
            case .regret:
                coordinator.push(
                    AppScene.emotionRegretMessage(
                        sendEmotion: sendEmotion,
                        receiverName: state.receiverName,
                        houseworkTitle: state.selectedHouseworkTitle,
                        receiverImg: state.receiverImg
                    )
                )
            }
        case .selectEmotion(let emotion):
            state.selectedEmotion = emotion
        }
    }
}
