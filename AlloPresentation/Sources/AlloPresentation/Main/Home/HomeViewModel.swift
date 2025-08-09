//
//  HomeViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

final class HomeViewModel: ViewModelable {
    @Published var state = State()
    private let appCoordinator: AppCoordinator
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    struct State {
    }
    enum Action {
        case homeAppear
        case homeDisappear
    }
    func action(_ action: Action) {
    }
}
