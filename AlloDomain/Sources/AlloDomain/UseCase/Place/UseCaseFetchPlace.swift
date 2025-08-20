//
//  UseCaseFetchPlace.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation

public protocol FetchPlacesUseCase {
    func execute() async throws -> [HouseworkPlace]
}
