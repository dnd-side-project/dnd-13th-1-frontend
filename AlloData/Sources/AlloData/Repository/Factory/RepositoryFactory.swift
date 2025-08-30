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
        HouseworkRepositoryImpl(networkService: networkService)
    }

    public func makeKakaoLoginRepository() -> KakaoLoginRepository {
        KakaoLoginRepositoryImpl(networkService: networkService)
    }
    
    public func makePlaceRepository(liveData: Bool) -> PlaceRepository {
        PlaceRepositoryImpl(networkService: networkService)
    }
    
    public func makeMemberRepository(liveData: Bool) -> MemberRepository {
        MemberRepositoryImpl(networkService: networkService)
    }
    
    public func makeGroupRepository(liveData: Bool) -> GroupRepository {
        liveData ? GroupRepositoryImpl(networkService: networkService) : StubGroupRepository()
    }
    
    public func makeGetGroupStateRepository() -> GetGroupStateRepository {
        GetGroupStateRepositoryImpl(networkService: networkService)
    }
    
    public func makeTagRepository(liveData: Bool) -> TagRepository {
        liveData ? TagRepositoryImpl(networkService: networkService) : StubTagRepository()
    }
    
    public func makeStatsRepository(liveData: Bool) -> StatsRepository {
        liveData ? StatsRepositoryImpl(networkService: networkService) : StubStatsRepository()
    }
    
    public func makeHouseworkSevenDaysRepository(liveData: Bool) -> HouseworkDaysRepository {
        HouseworkDaysRepositoryImpl(networkService: networkService)
    }
    
    public func makeEmotionRepository(liveData: Bool) -> EmotionRepository {
        EmotionRepositoryimpl(networkService: networkService)
    }
    
    public func makeAIRepository() -> AIRepository {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPENAI_API_KEY") as? String else {
            fatalError("OPENAI_API_KEY가 Info.plist에 없습니다.")
        }
        return AIRepositoryImpl(apiClient: AIAPIClient(apiKey: apiKey))
    }
    
    public func makeLogoutUseCase() -> LogoutUseCase {
        LogoutUseCaseImpl()
    }
}
