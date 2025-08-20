//
//  RepositoryFactory.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

public struct RepositoryFactory {
    public static func makeHouseworkRepository(liveData: Bool) -> HouseworkRepository {
        liveData ? HouseworkRepositoryImpl() : StubHouseworkRepository()
    }
    
    public static func makePlaceRepository(liveData: Bool) -> PlaceRepository {
        liveData ? PlaceRepositoryImpl() : StubPlaceRepository()
    }
}
