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
    let usecase: AddPlaceUseCase
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
            Task {
                await addPlace()
            }
        }
    }
    
    private func addPlace() async {
        guard !state.newPlaceName.isEmpty else { return }
        do {
            let newPlace: HouseworkPlace = try await usecase.execute(placeName: state.newPlaceName)
            state.existingPlaces.append(newPlace.name)
            state.newPlaceName = ""
            coordinator.dismissFullScreenCover()
        } catch {
            print("장소 추가 실패: \(error)")
        }
    }
}
