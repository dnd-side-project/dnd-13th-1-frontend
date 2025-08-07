//
//  HomeViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

final class HomeViewModel: ViewModelable {
    // MARK: - State & Action 타입 지정
    struct State {
    }
    enum Action {
    }
    // MARK: - Properties
    @Published private(set) var state = State()
    private let appCoordinator: AppCoordinator

    // MARK: - Init
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    // MARK: - Action 처리
    func action(_ action: Action) {
    }
}
