//
//  HomeViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public final class HomeViewModel: ViewModelable {
    @Published var state = State()
    let appCoordinator: Coordinator
    public init(appCoordinator: Coordinator) {
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
