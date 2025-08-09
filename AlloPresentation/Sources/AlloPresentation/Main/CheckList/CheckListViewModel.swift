//
//  CheckListViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public final class CheckListViewModel: ViewModelable {
    @Published var state = State()
    let appCoordinator: Coordinator
    public init(appCoordinator: Coordinator) {
        self.appCoordinator = appCoordinator
    }
    struct State {
    }
    enum Action {
        case checkListAppear
        case checkListDisappear
    }
    func action(_ action: Action) {
    }
}
