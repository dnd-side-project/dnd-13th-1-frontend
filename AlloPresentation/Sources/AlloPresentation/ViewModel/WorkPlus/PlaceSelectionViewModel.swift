//
//  PlaceSelectionViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/20/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class PlaceSelectionViewModel: ViewModelable {
    // MARK: - State
    public struct State {
        public var places: [HouseworkPlace] = []
        public var selectedCategory: HouseworkPlace?
    }
    // MARK: - Action
    enum Action {
        case selectPlace(HouseworkPlace)
        case addNewPlace
    }
    // MARK: - Properties
    public var state: State
    let coordinator: Coordinator
    private let fetchPlacesUseCase: FetchPlacesUseCase
    let onPlaceSelected: ((HouseworkPlace) -> Void)?

    // var selectedCategory: HouseworkPlace?
    // MARK: - Init
    public init(coordinator: Coordinator, initialPlace: String,
                fetchPlacesUseCase: FetchPlacesUseCase, onPlaceSelected: ((HouseworkPlace) -> Void)? = nil) {
        self.coordinator = coordinator
        self.fetchPlacesUseCase = fetchPlacesUseCase
        self.state = State()
        self.onPlaceSelected = onPlaceSelected
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .selectPlace(let place):
            state.selectedCategory = place
            onPlaceSelected?(place)
        case .addNewPlace:
            coordinator.dismissSheet()
            Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                coordinator.presentFullScreenCover(AppFullScreenCover.addHousePlace)
            }
        }
    }
    
    public func loadPlaces() async {
        do {
            let fetchedPlaces = try await fetchPlacesUseCase.execute()
            state.places = fetchedPlaces
            
            if let currentSelected = state.selectedCategory {
                if let matchedPlace = fetchedPlaces.first(where: { $0.name == currentSelected.name }) {
                    state.selectedCategory = matchedPlace
                } else {
                    state.selectedCategory = fetchedPlaces.first
                }
            } else {
                state.selectedCategory = fetchedPlaces.first
            }
            
        } catch {
            print("장소 불러오기 실패: \(error)")
        }
    }
    
}
