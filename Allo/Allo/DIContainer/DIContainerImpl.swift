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
    let liveData: Bool
    let repositoryFactory = RepositoryFactory()
  
    init(liveData: Bool) {
        self.liveData = liveData
    }

    private lazy var houseworkRepository: HouseworkRepository = repositoryFactory.makeHouseworkRepository(liveData: liveData)
    private lazy var kakaoLoginRepository: KakaoLoginRepository = repositoryFactory.makeKakaoLoginRepository()
    private lazy var placeRepository: PlaceRepository = repositoryFactory.makePlaceRepository(liveData: liveData)
    private lazy var memberRepository: MemberRepository = repositoryFactory.makeMemberRepository(liveData: liveData)
    private lazy var houseworkDaysRepository: HouseworkDaysRepository = repositoryFactory.makeHouseworkSevenDaysRepository(liveData: liveData)
    private lazy var emotionRepository: EmotionRepository = repositoryFactory.makeEmotionRepository(liveData: liveData)
    private lazy var aiRepository: AIRepository = repositoryFactory.makeAIRepository()
}
// MARK: - DIContainer 프로토콜 구현
extension DIContainerImpl: DIContainer {
    func resolveKakaoLoginUseCase() -> KakaoLoginUseCase {
        UseCaseFactory.makeKakaoLoginUseCase(kakaoLoginRepository: kakaoLoginRepository)
    }
    
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
    
    func resolvetransformAiUseCase() -> AIUseCase {
        UseCaseFactory.makeTransformAiUseCase(aiRepository: aiRepository)
    }
    
    func resolveDetailEmotionUseCase() -> EmotionDetailUseCase {
        UseCaseFactory.makeDetailEmotionUseCase(emotionRepository: emotionRepository)
    }
}
