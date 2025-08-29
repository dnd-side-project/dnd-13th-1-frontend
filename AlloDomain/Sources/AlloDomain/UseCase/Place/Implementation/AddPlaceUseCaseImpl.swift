//
//  AddPlaceUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/27/25.
//

import Foundation

final class AddPlaceUseCaseImpl {
    private let placeRepository: PlaceRepository
    init(placeRepository: PlaceRepository) {
        self.placeRepository = placeRepository
    }
}

extension AddPlaceUseCaseImpl: AddPlaceUseCase {
    func execute(placeName: String) async throws -> HouseworkPlace {
        return try await placeRepository.addPlace(placeName: placeName)
    }
}

