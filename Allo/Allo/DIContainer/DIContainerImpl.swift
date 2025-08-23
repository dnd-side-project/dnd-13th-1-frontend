//
//  DIContainerImpl.swift
//  Allo
//
//  Created by 김민솔 on 8/9/25.
//

import SwiftUI
import AlloData
import AlloDomain
import AlloPresentation

final class DIContainerImpl {
    private let houseworkRepository: HouseworkRepository
    private let placeRepository: PlaceRepository
    private let memberRepository: MemberRepository
    private let houseworkDaysRepository: HouseworkDaysRepository
    private let emotionRepository: EmotionRepository
    init(liveData: Bool = false) {
        self.houseworkRepository = RepositoryFactory.makeHouseworkRepository(liveData: liveData)
        self.placeRepository = RepositoryFactory.makePlaceRepository(liveData: liveData)
        self.memberRepository = RepositoryFactory.makeMemberRepository(liveData: liveData)
        self.houseworkDaysRepository = RepositoryFactory.makeHouseworkSevenDaysRepository(liveData: liveData)
        self.emotionRepository = RepositoryFactory.makeEmotionRepository(liveData: liveData)
    }
}
// MARK: - DIContainer 프로토콜 구현
extension DIContainerImpl: DIContainer {
    func resolveGenerateCalendarDateUseCase() -> GenerateCalendarDateUseCase {
        UseCaseFactory.makeGenerateCalendarDateUseCase()
    }
    
    func resolveCompleteHouseworkUseCase() -> CompleteHouseworkUseCase {
        UseCaseFactory.makeCompleteHouseworkUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveDeleteHouseworkUseCase() -> DeleteHouseworkUseCase {
        UseCaseFactory.makeDeleteHouseworkUseCase(houseworkRepository: houseworkRepository)
        
    }
    
    func resolveGetHouseworkListUseCase() -> GetHouseworkListUseCase {
        UseCaseFactory.makeGetHouseworkListUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveGetHaveHouseworkUseCase() -> GetHaveHouseworkUseCase {
        UseCaseFactory.makeGetHaveHouseworkUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveAddHouseworkUsecase() -> AddHouseworkUseCase {
        UseCaseFactory.makeAddHouseworkUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveFetchPlaceUsecase() -> FetchPlacesUseCase {
        UseCaseFactory.makeFetchPlaceUseCase(placeRepository: placeRepository)
    }
    
    func resolveFetchMemberUseCase() -> FetchMemberUseCase {
        UseCaseFactory.makeFetchMemberUseCase(memberRepository: memberRepository)
    }
    
    func resolveFetchDaysUseCase() -> FetchHouseworkDaysUseCase {
        UseCaseFactory.makeFetchHouseworkDaysUseCase(houseworkDaysRepository: houseworkDaysRepository)
    }
    
    func resolveSendEmotionUseCase() -> SendEmotionUseCase {
        UseCaseFactory.makeSendEmotionUseCase(emotionRepository: emotionRepository)
    }
    
    func resolveGetEmotionListUseCase() -> FetchEmotionUseCase {
        UseCaseFactory.makeGetEmotionListUseCase(emotionRepository: emotionRepository)
    }
}
