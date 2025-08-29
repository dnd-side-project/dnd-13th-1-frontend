//
//  LoginViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import AlloDomain

@Observable
public final class LoginViewModel: ViewModelable {
    struct State {
    }
    enum Action {
        case kakaoLoginButtonTapped
    }
    private let kakaoLoginUseCase: KakaoLoginUseCase
    var coordinator: Coordinator
    var state: State
    public init(coordinator: Coordinator, kakaoLoginUseCase: KakaoLoginUseCase) {
        self.state = .init()
        self.coordinator = coordinator
        self.kakaoLoginUseCase = kakaoLoginUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .kakaoLoginButtonTapped:
            Task {
                do {
                    try await kakaoLoginUseCase.execute()
                    coordinator.push(OnboardingScene.profileSetting)
                } catch(let error) {
                    dump(error)
                }
            }
        }
    }
}
