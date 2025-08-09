//
//  MyPageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public final class MyPageViewModel: ViewModelable {
    @Published var state = State()
    private let appCoordinator: Coordinator
    public init(appCoordinator: Coordinator) {
        self.appCoordinator = appCoordinator
    }
    struct State {
    }
    enum Action {
        case myPageAppear
        case myPageDisappear
    }
    func action(_ action: Action) {
    }
}
