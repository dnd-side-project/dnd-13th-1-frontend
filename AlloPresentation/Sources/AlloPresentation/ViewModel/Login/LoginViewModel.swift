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
    var state: State
    public init(kakaoLoginUseCase: KakaoLoginUseCase) {
        self.state = .init()
        self.kakaoLoginUseCase = kakaoLoginUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .kakaoLoginButtonTapped:
            Task {
                do {
                    let token = try await kakaoLoginUseCase.execute()
                } catch(let error) {
                    dump(error)
                }
            }
        }
    }
}
