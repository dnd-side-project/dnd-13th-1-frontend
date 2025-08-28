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
    private lazy var tagRepository: TagRepository = repositoryFactory.makeTagRepository(liveData: liveData)
    private lazy var groupRepository: GroupRepository = repositoryFactory.makeGroupRepository(liveData: liveData)
    private lazy var statsRepository: StatsRepository = repositoryFactory.makeStatsRepository(liveData: liveData)
}
// MARK: - DIContainer 프로토콜 구현
extension DIContainerImpl: DIContainer {
    func resolveCreateGroupUseCase() -> CreateGroupUseCase {
        UseCaseFactory.makeCreateGroupUseCase(groupRepository: groupRepository)
    }
    
    func resolveEnterGroupUseCase() -> EnterGroupUseCase {
        UseCaseFactory.makeEnterGroupUseCase(groupRepository: groupRepository)
    }
    
    func resolveGetMyGroupUseCase() -> GetMyGroupUseCase {
        UseCaseFactory.makeGetMyGroupUseCase(groupRepository: groupRepository)
    }
    
    func resolveFetchTagsUseCase() -> FetchTagsUseCase {
        UseCaseFactory.makeFetchTagsUseCase(tagRepository: tagRepository)
    }
    
    func resolveAddTagUseCase() -> AddTagUseCase {
        UseCaseFactory.makeAddTagUseCase(tagRepository: tagRepository)
    }
    
    func resolveGetCleanlinessUseCase() -> GetCleanlinessUseCase {
        UseCaseFactory.makeGetCleanlinessUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetMyContributionUseCase() -> GetMyContributionUseCase {
        UseCaseFactory.makeGetMyContributionUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetTodayCompletionStatusUseCase() -> GetTodayCompletionStatusUseCase {
        UseCaseFactory.makeGetTodayCompletionStatusUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetWeekCompletionStatusUseCase() -> GetWeekCompletionStatusUseCase {
        UseCaseFactory.makeGetWeekCompletionStatusUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetTwoWeekComparisonUseCase() -> GetTwoWeekComparisonUseCase {
        UseCaseFactory.makeGetTwoWeekComparisonUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetActivitySummaryUseCase() -> GetActivitySummaryUseCase {
        UseCaseFactory.makeGetActivitySummaryUseCase(statsRepository: statsRepository)
    }
    
    func resolveGetHouseworkDetailUseCase() -> GetHouseworkDetailUseCase {
        UseCaseFactory.makeGetHouseworkDetailUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveGetMyRecentHouseworkUseCase() -> GetMyRecentHouseworkUseCase {
        UseCaseFactory.makeGetMyRecentHouseworkUseCase(houseworkRepository: houseworkRepository)
    }
    
    func resolveGetTodayPlaceHouseworkUseCase() -> GetTodayPlaceHouseworkUseCase {
        UseCaseFactory.makeGetTodayPlaceHouseworkUseCase(houseworkRepository: houseworkRepository)
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
}
