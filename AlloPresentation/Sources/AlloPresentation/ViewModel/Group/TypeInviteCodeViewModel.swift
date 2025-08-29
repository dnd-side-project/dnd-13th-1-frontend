//
//  TypeInviteCodeViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import Foundation
import AlloDomain

@Observable
@MainActor
public final class TypeInviteCodeViewModel: ViewModelable {
    struct State {
        var inputText: String = ""
    }
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    let enterGroupUseCase: EnterGroupUseCase
    let setMyGroupUseCase: SetMyGroupUseCase
    public init(coordinator: Coordinator, enterGroupUseCase: EnterGroupUseCase, setMyGroupUseCase: SetMyGroupUseCase) {
        self.state = .init()
        self.coordinator = coordinator
        self.enterGroupUseCase = enterGroupUseCase
        self.setMyGroupUseCase = setMyGroupUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            Task {
                do {
                    let groupInfo = try await enterGroupUseCase.execute(inviteCode: state.inputText)
                    coordinator.popToRoot()
                    setMyGroupUseCase.execute(groupId: groupInfo.groupId)
                } catch {
                    dump(error)
                }
            }
        }
    }
}
