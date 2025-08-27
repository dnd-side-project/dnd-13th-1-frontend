//
//  StubPlaceRepository.swift
//  AlloData
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation
import AlloDomain

struct StubPlaceRepository: PlaceRepository {
    func fetchPlaces() async throws -> [HouseworkPlace] {
        return [
            HouseworkPlace(placeId: "1", name: "거실"),
            HouseworkPlace(placeId: "2", name: "주방"),
            HouseworkPlace(placeId: "3", name: "화장실")
        ]
    }
}

