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
        liveData ? HouseworkRepositoryImpl(networkService: networkService) : StubHouseworkRepository()
    }

    public func makeKakaoLoginRepository() -> KakaoLoginRepository {
        KakaoLoginRepositoryImpl(networkService: networkService)
    }
    
    public func makePlaceRepository(liveData: Bool) -> PlaceRepository {
        liveData ? PlaceRepositoryImpl(networkService: networkService) : StubPlaceRepository()
    }
    
    public func makeMemberRepository(liveData: Bool) -> MemberRepository {
        liveData ? MemberRepositoryImpl(networkService: networkService) : StubMemberRepository()
    }
    
    public func makeGroupRepository(liveData: Bool = true) -> GroupRepository {
        liveData ? GroupRepositoryImpl(networkService: networkService) : StubGroupRepository()
    }
    
    public func makeTagRepository(liveData: Bool = true) -> TagRepository {
        liveData ? TagRepositoryImpl(networkService: networkService) : StubTagRepository()
    }
    
    public func makeEmotionRepository(liveData: Bool = true) -> EmotionRepository {
        liveData ? EmotionRepositoryImpl(networkService: networkService) : StubEmotionRepository()
    }
    
    public func makeStatsRepository(liveData: Bool = true) -> StatsRepository {
        liveData ? StatsRepositoryImpl(networkService: networkService) : StubStatsRepository()
    }
}
