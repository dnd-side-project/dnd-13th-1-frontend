//
//  ShareInviteCodeViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import Foundation
import AlloDomain
import UIKit

@Observable
@MainActor
public final class ShareInviteCodeViewModel: ViewModelable {
    struct State {
        var inviteCode: String
        var groupId: Int
    }
    enum Action {
        case didTapBackButton
        case didTapCopyButton
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    let setMyGroupUseCase: SetMyGroupUseCase
    public init(coordinator: Coordinator, inviteCode: String, groupId: Int, setMyGroupUseCase: SetMyGroupUseCase) {
        self.state = .init(inviteCode: inviteCode, groupId: groupId)
        self.coordinator = coordinator
        self.setMyGroupUseCase = setMyGroupUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapCopyButton:
            UIPasteboard.general.string = state.inviteCode
        case .didTapNextButton:
            coordinator.popToRoot()
            setMyGroupUseCase.execute(groupId: state.groupId)
        }
    }
}
