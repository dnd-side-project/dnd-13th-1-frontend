//
//  EmotionDetailViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/26/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionDetailViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var emotionDetail: EmotionDetail
        var isReceived: Bool
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapSendButton
        case didTapDeleteButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    //usecase
    let emotionDetailUseCase: EmotionDetailUseCase
    let emotionDeleteUseCase: EmotionDeleteUseCase
    public init(coordinator: Coordinator, emotionDetailUseCase: EmotionDetailUseCase, emotionDetail: EmotionDetail, isReceived: Bool, emotionDeleteUseCase: EmotionDeleteUseCase) {
        self.coordinator = coordinator
        self.emotionDetailUseCase = emotionDetailUseCase
        self.emotionDeleteUseCase = emotionDeleteUseCase
        self.state = State(emotionDetail: emotionDetail, isReceived: isReceived)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.popToRoot()
        case .didTapDeleteButton:
            Task {
                do {
                    try await emotionDeleteUseCase.execute(state.emotionDetail.emotionCardId)
                    
                    // 삭제 후 화면 뒤로
                    coordinator.pop()
                } catch {
                    print("Emotion 삭제 실패: \(error)")
                }
            }
            
        }
    }
}
