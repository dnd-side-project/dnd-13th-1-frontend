//
//  PlaceSelectionViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/20/25.
//

import SwiftUI
import AlloDomain

public final class PlaceSelectionViewModel: ViewModelable {
    // MARK: - State
    public struct State {
        public var places: [HouseworkPlace]
        public init(places: [HouseworkPlace]) {
            self.places = places
        }
    }
    
    // MARK: - Action
    enum Action {
    }
    
    // MARK: - Properties
    public var state: State
    let coordinator: Coordinator
    private let fetchPlacesUseCase: FetchPlacesUseCase
    var selectedCategory: HouseworkPlace?
    // MARK: - Init
    public init(coordinator: Coordinator,places: [HouseworkPlace],
                fetchPlacesUseCase: FetchPlacesUseCase) {
        self.coordinator = coordinator
        self.fetchPlacesUseCase = fetchPlacesUseCase
        self.state = State(places: places)
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
    }
}
