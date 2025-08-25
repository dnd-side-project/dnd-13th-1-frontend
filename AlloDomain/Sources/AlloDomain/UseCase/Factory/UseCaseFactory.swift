//
//  UseCaseFactory.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public struct UseCaseFactory {
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
}
