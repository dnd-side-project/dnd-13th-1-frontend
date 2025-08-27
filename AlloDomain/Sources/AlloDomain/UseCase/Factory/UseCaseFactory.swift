//
//  UseCaseFactory.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public struct UseCaseFactory {
    // MARK: Login
    public static func makeKakaoLoginUseCase(kakaoLoginRepository: KakaoLoginRepository) -> KakaoLoginUseCase {
        return KakaoLoginUseCaseImpl(repository: kakaoLoginRepository)
    }
    
    // MARK: Housework
    public static func makeAddHouseworkUseCase(houseworkRepository: HouseworkRepository) -> AddHouseworkUseCase {
        return AddHouseworkUseCaseImpl(houseworkRepository: houseworkRepository)
    }
    
    public static func makeCompleteHouseworkUseCase(houseworkRepository: HouseworkRepository) -> CompleteHouseworkUseCase {
        return CompleteHouseworkUseCaseImpl(houseworkRepository: houseworkRepository)
    }
    
    public static func makeDeleteHouseworkUseCase(houseworkRepository: HouseworkRepository) -> DeleteHouseworkUseCase {
        return DeleteHouseworkUseCaseImpl(houseworkRepository: houseworkRepository)
    }
    
    public static func makeGetHaveHouseworkUseCase(houseworkRepository: HouseworkRepository) -> GetHaveHouseworkUseCase {
        return GetHaveHouseworkUseCaseImpl(houseworkRepository: houseworkRepository)
    }
    
    public static func makeGetHouseworkListUseCase(houseworkRepository: HouseworkRepository) -> GetHouseworkListUseCase {
        return GetHouseworkListUseCaseImpl(houseworkRepository: houseworkRepository)
    }
    
    public static func makeGenerateCalendarDateUseCase() -> GenerateCalendarDateUseCase {
        return GenerateCalendarDateUseCaseImpl()
    }
    
    public static func makeFetchPlaceUseCase(placeRepository: PlaceRepository) -> FetchPlacesUseCase {
        return FetchPlacesUseCaseImpl(placeRepository: placeRepository)
    }
    
    public static func makeFetchMemberUseCase(memberRepository: MemberRepository) -> FetchMemberUseCase {
        return FetchMemberUseCaseImpl(memberRepository: memberRepository)
    }
    
    // MARK: Group
    public static func makeCreateGroupUseCase(groupRepository: GroupRepository) -> CreateGroupUseCase {
        return CreateGroupUseCaseImpl(repo: groupRepository)
    }
    public static func makeEnterGroupUseCase(groupRepository: GroupRepository) -> EnterGroupUseCase {
        return EnterGroupUseCaseImpl(repo: groupRepository)
    }
    public static func makeGetMyGroupUseCase(groupRepository: GroupRepository) -> GetMyGroupUseCase {
        return GetMyGroupUseCaseImpl(repo: groupRepository)
    }
    
    // MARK: Tag
    public static func makeFetchTagsUseCase(tagRepository: TagRepository) -> FetchTagsUseCase {
        return FetchTagsUseCaseImpl(repo: tagRepository)
    }
    public static func makeAddTagUseCase(tagRepository: TagRepository) -> AddTagUseCase {
        return AddTagUseCaseImpl(repo: tagRepository)
    }
    
    // MARK: Stats
    public static func makeGetCleanlinessUseCase(statsRepository: StatsRepository) -> GetCleanlinessUseCase { GetCleanlinessUseCaseImpl(repo: statsRepository) }
    public static func makeGetMyContributionUseCase(statsRepository: StatsRepository) -> GetMyContributionUseCase { GetMyContributionUseCaseImpl(repo: statsRepository) }
    public static func makeGetTodayCompletionStatusUseCase(statsRepository: StatsRepository) -> GetTodayCompletionStatusUseCase { GetTodayCompletionStatusUseCaseImpl(repo: statsRepository) }
    public static func makeGetWeekCompletionStatusUseCase(statsRepository: StatsRepository) -> GetWeekCompletionStatusUseCase { GetWeekCompletionStatusUseCaseImpl(repo: statsRepository) }
    public static func makeGetTwoWeekComparisonUseCase(statsRepository: StatsRepository) -> GetTwoWeekComparisonUseCase { GetTwoWeekComparisonUseCaseImpl(repo: statsRepository) }
    public static func makeGetActivitySummaryUseCase(statsRepository: StatsRepository) -> GetActivitySummaryUseCase { GetActivitySummaryUseCaseImpl(repo: statsRepository) }
    
    // MARK: Housework Extras
    public static func makeGetHouseworkDetailUseCase(houseworkRepository: HouseworkRepository) -> GetHouseworkDetailUseCase { GetHouseworkDetailUseCaseImpl(repo: houseworkRepository) }
    public static func makeGetMyRecentHouseworkUseCase(houseworkRepository: HouseworkRepository) -> GetMyRecentHouseworkUseCase { GetMyRecentHouseworkUseCaseImpl(repo: houseworkRepository) }
    public static func makeGetTodayPlaceHouseworkUseCase(houseworkRepository: HouseworkRepository) -> GetTodayPlaceHouseworkUseCase { GetTodayPlaceHouseworkUseCaseImpl(repo: houseworkRepository) }
    
    public static func makeFetchHouseworkDaysUseCase(houseworkDaysRepository: HouseworkDaysRepository) -> FetchHouseworkDaysUseCase {
        return FetchHouseworkDaysUseCaseImpl(houseworkDaysRepository: houseworkDaysRepository)
    }
    
    public static func makeSendEmotionUseCase(emotionRepository: EmotionRepository) -> SendEmotionUseCase {
        return EmotionUseCaseImpl(emotionRepository: emotionRepository)
    }
    
    public static func makeGetEmotionListUseCase(emotionRepository: EmotionRepository) -> FetchEmotionUseCase {
        return FetchEmotionUseCaseImpl(emotionRepository: emotionRepository)
    }
    
    public static func makeTransformAiUseCase(aiRepository: AIRepository) -> AIUseCase {
        return AIUseCaseImpl(aiRepository: aiRepository)
    }
    
    public static func makeDetailEmotionUseCase(emotionRepository: EmotionRepository) -> EmotionDetailUseCase {
        return EmotionDetailUseCaseImpl(emotionDetailRepository: emotionRepository)
    }
}
