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
    func execute(groupId: Int, placeName: String) async throws {
        return try await placeRepository.addPlace(groupId: groupId, placeName: placeName)
    }
}

