//
//  FetchPlacesUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation

public protocol FetchPlacesUseCase: Sendable {
    func execute(groupId: Int) async throws -> [HouseworkPlace]
}
