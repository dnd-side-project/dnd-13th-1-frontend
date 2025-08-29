//
//  HomeInviteCodeViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/30/25.
//

import AlloDomain
import UIKit

@Observable
public final class HomeInviteCodeViewModel: ViewModelable {
    struct State {
        var inviteCode: String
    }
    enum Action {
        case load
        case didTapCopyButton
        case backButtonTapped
    }
    private let getMyGroupUseCase: GetMyGroupUseCase
    var coordinator: Coordinator
    var state: State
    public init(coordinator: Coordinator, getMyGroupUseCase: GetMyGroupUseCase) {
        self.coordinator = coordinator
        self.getMyGroupUseCase = getMyGroupUseCase
        self.state = State(inviteCode: "")
    }
    func action(_ action: Action) {
        switch action {
        case .load:
            Task {
                do {
                    let groupInfo = try await getMyGroupUseCase.execute()
                    state.inviteCode = groupInfo.inviteCode ?? "에러"
                } catch(let error) {
                    dump(error)
                }
            }
        case .backButtonTapped:
            coordinator.pop()
        case .didTapCopyButton:
            UIPasteboard.general.string = state.inviteCode
        }
    }
}
