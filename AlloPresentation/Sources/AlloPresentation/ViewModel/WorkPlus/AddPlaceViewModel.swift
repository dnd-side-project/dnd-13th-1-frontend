//
//  AddPlaceViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/18/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddPlaceViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var newPlaceName: String = ""
        var existingPlaces: [String] = []
        var groupId: String? = ""
    }
    
    var state: State
    let coordinator: Coordinator
    let usecase : AddPlaceUseCase
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapAddPlaceButton
    }
    
    // MARK: - Init
    public init(coordinator: Coordinator, usecase: AddPlaceUseCase, existingPlaces: [String] = []) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.state = State(existingPlaces: existingPlaces)
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.dismissFullScreenCover()
        case .didTapAddPlaceButton:
            coordinator.dismissFullScreenCover()
            Task {
                await addPlace()
            }
        }
    }
    
    private func addPlace() async {
            guard !state.newPlaceName.isEmpty else { return }
            guard let groupIdString = state.groupId, let groupIdInt = Int(groupIdString) else {
                print("그룹ID가 유효하지 않습니다.")
                return
            }

            do {
                try await usecase.execute(groupId: groupIdInt, placeName: state.newPlaceName)
                state.existingPlaces.append(state.newPlaceName)
                state.newPlaceName = ""
                coordinator.dismissFullScreenCover()
            } catch {
                print("장소 추가 실패: \(error)")
            }
        }
    
}
