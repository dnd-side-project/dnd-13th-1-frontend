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
    
}
