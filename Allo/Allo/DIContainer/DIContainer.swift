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
    func resolveLogoutUseCase() -> LogoutUseCase
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
    // MARK: - Member UseCase
    func resolveFetchMemberUseCase() -> FetchMemberUseCase
    func resolvePatchMyProfileUseCase() -> PatchMyProfileUseCase
    // MARK: - Group UseCases
    func resolveCreateGroupUseCase() -> CreateGroupUseCase
    func resolveEnterGroupUseCase() -> EnterGroupUseCase
    func resolveGetMyGroupUseCase() -> GetMyGroupUseCase
    func resolveSetMyGroupUseCase() -> SetMyGroupUseCase
    func resolveGetGroupStateUseCase() -> GetGroupStateUseCase
    // MARK: - Tag UseCases
    func resolveFetchTagsUseCase() -> FetchTagsUseCase
    func resolveAddTagUseCase() -> AddTagUseCase
    // MARK: - Stats UseCases
    func resolveGetCleanlinessUseCase() -> GetCleanlinessUseCase
    func resolveGetMyContributionUseCase() -> GetMyContributionUseCase
    func resolveGetTodayCompletionStatusUseCase() -> GetTodayCompletionStatusUseCase
    func resolveGetWeekCompletionStatusUseCase() -> GetWeekCompletionStatusUseCase
    func resolveGetTwoWeekComparisonUseCase() -> GetTwoWeekComparisonUseCase
    func resolveGetActivitySummaryUseCase() -> GetActivitySummaryUseCase
    // MARK: - Housework Extra UseCases
    func resolveGetHouseworkDetailUseCase() -> GetHouseworkDetailUseCase
    func resolveGetMyRecentHouseworkUseCase() -> GetMyRecentHouseworkUseCase
    func resolveGetTodayPlaceHouseworkUseCase() -> GetTodayPlaceHouseworkUseCase
    // MARK: -- Emotion UseCase
    func resolveFetchDaysUseCase() -> FetchHouseworkDaysUseCase
    func resolveSendEmotionUseCase() -> SendEmotionUseCase
    func resolveGetEmotionListUseCase() -> FetchEmotionUseCase
    func resolvetransformAiUseCase() -> AIUseCase
    func resolveDetailEmotionUseCase() -> EmotionDetailUseCase
    func resolveDeleteEmotionUseCase() -> EmotionDeleteUseCase
}
