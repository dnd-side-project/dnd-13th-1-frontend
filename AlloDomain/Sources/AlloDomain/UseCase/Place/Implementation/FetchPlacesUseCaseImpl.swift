//
//  FetchPlacesUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation

final class FetchPlacesUseCaseImpl {
    private let placeRepository: PlaceRepository
    init(placeRepository: PlaceRepository) {
        self.placeRepository = placeRepository
    }
}

extension FetchPlacesUseCaseImpl: FetchPlacesUseCase {
    func execute(groupId: Int) async throws -> [HouseworkPlace] {
        return try await placeRepository.fetchPlaces(groupId: groupId)
    }
}
