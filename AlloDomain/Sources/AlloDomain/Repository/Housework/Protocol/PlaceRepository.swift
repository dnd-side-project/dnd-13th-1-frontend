//
//  PlaceRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation

public protocol PlaceRepository: Sendable {
    func fetchPlaces(groupId: Int) async throws -> [HouseworkPlace]
}
