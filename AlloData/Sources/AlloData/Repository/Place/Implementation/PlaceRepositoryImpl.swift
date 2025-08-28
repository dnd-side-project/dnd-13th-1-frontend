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
    
    func addPlace(groupId: Int, placeName: String) async throws {
        try await networkService.addPlace(groupId, placeName: placeName)

    func fetchPlaces() async throws -> [HouseworkPlace] {
        guard let groupId = UserDefaultsService.groupId else { return [] }
        let dto = try await networkService.getPlaceList(groupId)
        return dto.map { element in
            HouseworkPlace(placeId: String(element.placeId), name: element.name)
        }
    }
}
