//
//  PlaceRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation
import Moya
import AlloDomain

final class PlaceRepositoryImpl: PlaceRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPlaces(groupId: Int) async throws -> [HouseworkPlace] {
        let dto = try await networkService.getPlaceList(groupId)
        return dto.map { HouseworkPlace(placeId: $0.placeId, name: $0.name) }
    }
    
    func addPlace(groupId: Int, placeName: String) async throws {
        try await networkService.addPlace(groupId, placeName: placeName)
    }
}
