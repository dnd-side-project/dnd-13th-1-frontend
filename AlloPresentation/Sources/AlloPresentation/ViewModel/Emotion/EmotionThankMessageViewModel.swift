//
//  EmotionThankMessageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionThankMessageViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var sendEmotion: SendEmotion
        var receiverName: String
        var houseworkTitle: String
        var selectedCompliments: Set<Compliments> = []
        var customCompliment: String = ""
    }
    // MARK: - Action
    enum Action {
        case selectCompliment(Compliments)
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworkTitle: houseworkTitle)
    }
    
    func action(_ action: Action) {
        switch action {
        case .selectCompliment(let compliment):
            if state.selectedCompliments.contains(compliment) {
                state.selectedCompliments.remove(compliment)
            } else if state.selectedCompliments.count < 3 {
                state.selectedCompliments.insert(compliment)
            }
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: "",
                compliments: state.selectedCompliments.map { $0.rawValue }
            )
            coordinator.push(AppScene.emotionRegretMessage(sendEmotion: sendEmotion, receiverName: state.receiverName, houseworkTitle: state.houseworkTitle))
        }
    }
}
