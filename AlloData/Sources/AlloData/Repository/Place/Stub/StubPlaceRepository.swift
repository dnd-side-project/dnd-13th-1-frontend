//
//  StubPlaceRepository.swift
//  AlloData
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation
import AlloDomain

public final class StubPlaceRepository: PlaceRepository {
    public init() {}

    public func fetchPlaces() async throws -> [HouseworkPlace] {
        return [
            HouseworkPlace(placeId: "1", name: "방"),
            HouseworkPlace(placeId: "2", name: "욕실"),
            HouseworkPlace(placeId: "3", name: "주방"),
            HouseworkPlace(placeId: "4", name: "세탁"),
            HouseworkPlace(placeId: "5", name: "기타")
        ]
    }
}

