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
}
