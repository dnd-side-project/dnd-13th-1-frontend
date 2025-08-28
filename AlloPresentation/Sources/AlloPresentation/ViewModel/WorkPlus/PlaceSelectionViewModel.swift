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
   // var selectedCategory: HouseworkPlace?
    // MARK: - Init
    public init(coordinator: Coordinator, initialPlace: String,
                fetchPlacesUseCase: FetchPlacesUseCase) {
        self.coordinator = coordinator
        self.fetchPlacesUseCase = fetchPlacesUseCase
        self.state = State()
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .selectPlace(let place):
            state.selectedCategory = place
        case .addNewPlace:
            coordinator.dismissSheet()
            coordinator.presentFullScreenCover(
                AppFullScreenCover.addHousePlace(onComplete: { [weak self] _ in
                    Task { [weak self] in
                        await self?.loadPlaces()
                        self?.coordinator.dismissFullScreenCoverAndReturnToSheet(
                            AppSheet.placeSelection(
                                initialPlace: self?.state.selectedCategory?.name ?? "",
                                placeClickAction: { [weak self] name, id in
                                    guard let self else { return }
                                    self.state.selectedCategory = HouseworkPlace(placeId: id, name: name)
                                    self.coordinator.dismissSheet()
                                }
                            )
                        )
                    }
                })
            )
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
