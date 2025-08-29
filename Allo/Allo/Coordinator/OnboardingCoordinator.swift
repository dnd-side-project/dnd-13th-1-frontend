//
//  OnboardingCoordinator.swift
//  Allo
//
//  Created by 황채웅 on 8/17/25.
//

import SwiftUI
import AlloPresentation
import AlloDomain
import AlloData

@Observable
final class OnboardingCoordinator: Coordinator {
    var diContainer: DIContainer
    var path = NavigationPath()
    var sheet: (any AppRoute)?
    var appSheet: AppSheet? {
        get { sheet as? AppSheet }
        set { sheet = newValue }
    }
    var fullScreenCover: (any AppRoute)?
    var appFullScreenCover: AppFullScreenCover? {
        get { fullScreenCover as? AppFullScreenCover }
        set { fullScreenCover = newValue }
    }
    var sheetOnDismiss: (() -> Void)?
    var fullScreenCoverOnDismiss: (() -> Void)?
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    @MainActor
    @ViewBuilder
    func buildScene(_ scene: OnboardingScene) -> some View {
        switch scene {
        case .onboarding:
            OnboardingView(viewModel: OnboardingViewModel(coordinator: self))
        case .login:
            LoginView(viewModel: LoginViewModel(coordinator: self, kakaoLoginUseCase: diContainer.resolveKakaoLoginUseCase()))
        case .profileSetting:
            ProfileSettingView(viewModel: ProfileSettingViewModel(coordinator: self, patchMyProfileUseCase: diContainer.resolvePatchMyProfileUseCase()))
        case let .onboardingComplete(nickname):
            OnboardingCompleteView(viewModel: OnboardingCompleteViewModel(coordinator: self, nickname: nickname))
        case .enterGroup:
            TypeInviteCodeView(
                viewModel: TypeInviteCodeViewModel(
                    coordinator: self,
                    enterGroupUseCase: diContainer.resolveEnterGroupUseCase(),
                    setMyGroupUseCase: diContainer.resolveSetMyGroupUseCase()
                )
            )
        case .createGroup:
            SelectGroupTypeView(
                viewModel: SelectGroupTypeViewModel(
                    coordinator: self,
                    createGroupUseCase: diContainer.resolveCreateGroupUseCase()
                )
            )
        case .copyInviteCode(inviteCode: let inviteCode, groupId: let groupId):
            ShareInviteCodeView(
                viewModel: ShareInviteCodeViewModel(
                    coordinator: self,
                    inviteCode: inviteCode,
                    groupId: groupId,
                    setMyGroupUseCase: diContainer.resolveSetMyGroupUseCase()
                )
            )
        }
    }
    @MainActor
    @ViewBuilder
    func buildSheet(_ sheet: OnboardingSheet) -> some View {
    }
    @MainActor
    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: OnboardingFullScreenCover) -> some View {
    }

}
