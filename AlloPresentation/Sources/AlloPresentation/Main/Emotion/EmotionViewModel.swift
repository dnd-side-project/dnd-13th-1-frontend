//
//  EmotionViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

final class EmotionViewModel: ViewModelable {
    @Published var state = State()
    private let appCoordinator: AppCoordinator
    init(appCoordinator: AppCoordinator) {
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
