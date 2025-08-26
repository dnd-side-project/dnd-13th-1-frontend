//
//  RepositoryFactory.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

public struct RepositoryFactory {
    
    private let networkService: NetworkService
    
    public init() {
        networkService = NetworkService()
    }
    
    public func makeHouseworkRepository(liveData: Bool) -> HouseworkRepository {
        liveData ? HouseworkRepositoryImpl() : StubHouseworkRepository()
    }

    public func makeKakaoLoginRepository() -> KakaoLoginRepository {
        KakaoLoginRepositoryImpl(networkService: networkService)
    }
    
    public func makePlaceRepository() -> PlaceRepository {
        PlaceRepositoryImpl(networkService: networkService)
    }
    
    public func makeMemberRepository() -> MemberRepository {
        MemberRepositoryImpl(networkService: networkService)
    }
}
