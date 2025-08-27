//
//  DIContainer.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI
import AlloData
import AlloDomain

public protocol DIContainer {
    // MARK: - Auth UseCases
    func resolveKakaoLoginUseCase() -> KakaoLoginUseCase
    // MARK: - User UseCases
    // MARK: - CheckList UseCases
    func resolveGenerateCalendarDateUseCase() -> GenerateCalendarDateUseCase
    func resolveCompleteHouseworkUseCase() -> CompleteHouseworkUseCase
    func resolveDeleteHouseworkUseCase() -> DeleteHouseworkUseCase
    func resolveGetHouseworkListUseCase() -> GetHouseworkListUseCase
    func resolveGetHaveHouseworkUseCase() -> GetHaveHouseworkUseCase
    // MARK: -- AddHousework UseCases
    func resolveAddHouseworkUsecase() -> AddHouseworkUseCase
    func resolveFetchPlaceUsecase() -> FetchPlacesUseCase
    func resolveAddPlaceUseCase() -> AddPlaceUseCase
    func resolveAddTagUseCase() -> TagAddUseCase
    func resolveGetTagListUseCase() -> TagListUseCase
    // MARK: - Member UseCase
    func resolveFetchMemberUseCase() -> FetchMemberUseCase
}
