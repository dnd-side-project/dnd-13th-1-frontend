//
//  HouseworkPlace.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/20/25.
//

import Foundation

public final class HouseworkPlace: Equatable, Identifiable {
    public let placeId: String
    public let name: String
    public static func == (lhs: HouseworkPlace, rhs: HouseworkPlace) -> Bool {
        lhs.id == rhs.id
    }
    public init(placeId: String, name: String) {
        self.placeId = placeId
        self.name = name
    }
}
