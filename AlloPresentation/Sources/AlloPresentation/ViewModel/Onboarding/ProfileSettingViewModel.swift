//
//  ProfileSettingViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import SwiftUI
import PhotosUI
import AlloDomain

@Observable
@MainActor
public final class ProfileSettingViewModel: ViewModelable {
    struct State {
        var nickname: String = ""
        var profileImage: ImageResource?
        var isPresentingPhotoPicker: Bool = false
        var photoSelection: PhotosPickerItem?
        var profileUIImage: UIImage?
    }
    enum Action {
        case didTapBackButton
        case didTapImageButton
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    private let patchMyProfileUseCase: PatchMyProfileUseCase
    public init(coordinator: Coordinator, patchMyProfileUseCase: PatchMyProfileUseCase) {
        self.coordinator = coordinator
        self.patchMyProfileUseCase = patchMyProfileUseCase
        self.state = State()
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapImageButton:
            state.isPresentingPhotoPicker = true
        case .didTapNextButton:
            Task { [state] in
                guard let image = state.profileUIImage, let data = image.pngData() else {
                    await MainActor.run {
                        coordinator.push(OnboardingScene.onboardingComplete(nickname: state.nickname))
                    }
                    return
                }
                do {
                    try await patchMyProfileUseCase.execute(nickname: state.nickname, imageData: data)
                    await MainActor.run {
                        coordinator.push(OnboardingScene.onboardingComplete(nickname: state.nickname))
                    }
                } catch {
                    await MainActor.run {
                        coordinator.push(OnboardingScene.onboardingComplete(nickname: state.nickname))
                    }
                }
            }
        }
    }

    func loadSelectedPhoto() async {
        guard let item = state.photoSelection else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                state.profileUIImage = image
            }
        } catch {
            dump(error)
        }
    }
}
