//
//  CheckListViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

final class CheckListViewModel: ViewModelable {
    // MARK: - State & Action 타입 지정
    struct State {
    }
    enum Action {
        case checkListAppear
        case checkListDisappear
    }
    // MARK: - Properties
    @Published var state = State()
    private let appCoordinator: AppCoordinator
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    // MARK: - Action 처리
    func action(_ action: Action) {
    }
}
