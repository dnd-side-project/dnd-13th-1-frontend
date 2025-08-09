//
//  EmotionViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public final class EmotionViewModel: ViewModelable {
    @Published var state = State()
    private let appCoordinator: Coordinator
    public init(appCoordinator: Coordinator) {
        self.appCoordinator = appCoordinator
    }
    struct State {
    }
    enum Action {
        case emotionAppear
        case emotionDisappear
    }
    func action(_ action: Action) {
    }
}
