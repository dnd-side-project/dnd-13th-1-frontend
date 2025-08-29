//
//  AddPlaceUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/27/25.
//

import Foundation

public protocol AddPlaceUseCase: Sendable {
    func execute(placeName: String) async throws -> HouseworkPlace
}
