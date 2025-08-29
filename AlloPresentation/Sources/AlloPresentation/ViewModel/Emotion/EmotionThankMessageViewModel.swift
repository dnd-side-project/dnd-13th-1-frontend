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
        var initialEmotion: EmotionType
        var receiverImg: URL?
    }
    // MARK: - Action
    enum Action {
        case selectCompliment(Compliments)
        case didTapBackButton
        case didTapNextButton
        case focusLost
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, initialEmotion: EmotionType, receiverImg: URL?) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworkTitle: houseworkTitle, initialEmotion: initialEmotion, receiverImg: receiverImg)
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
            
        case .focusLost:
            // 포커스 해제 시 customCompliment 값이 있으면 자동으로 .sevenThank 버튼 선택
            if !state.customCompliment.isEmpty {
                state.selectedCompliments.insert(.sevenThank)
            } else {
                // 입력값이 없으면 .sevenThank 선택 해제
                state.selectedCompliments.remove(.sevenThank)
            }
        case .didTapNextButton:
            let compliments: [String] = state.selectedCompliments.map { compliment in
                if compliment == .sevenThank {
                    return state.customCompliment // 직접 입력한 텍스트
                } else {
                    return compliment.rawValue
                }
            }
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: state.sendEmotion.houseWorkId,
                disappointment: "",
                compliments: compliments
            )
            
            switch state.initialEmotion {
            case .thank:
                coordinator.push(
                    AppScene.emotionFinish(
                        sendEmotion: sendEmotion,
                        receiverName: state.receiverName,
                        houseworkTitle: state.houseworkTitle
                    )
                )
            case .both:
                coordinator.push(
                    AppScene.emotionRegretMessage(
                        sendEmotion: sendEmotion,
                        receiverName: state.receiverName,
                        houseworkTitle: state.houseworkTitle,
                        receiverImg: state.receiverImg
                    )
                )
            case .regret:
                break
            
            }
            
        }
    }
}
