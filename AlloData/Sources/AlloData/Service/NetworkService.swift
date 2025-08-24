//
//  NetworkService.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Moya
import Foundation

/// Endpoint를 정의합니다
/// 분리하여도 좋지만, 소규모 프로젝트이기 떄문에 하나의 구조체로 관리합니다
struct NetworkService: Sendable {
    
    func logout() {
        try? KeychainService.delete(key: "accessToken")
        UserDefaultsService.isSignedIn = false
    }
    
    private let provider = MoyaProvider<AlloAPI>()
    
    func createGroup(_ charcterId: Int) async throws -> CreateGroupResponseDTO {
        let response = try await provider.request(.createGroup(characterId: charcterId))
        let responseDTO = try JSONDecoder().decode(CreateGroupResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func enterGroup(_ inviteCode: String) async throws -> EnterGroupResponseDTO {
        let response = try await provider.request(.enterGroup(inviteCode: inviteCode))
        let responseDTO = try JSONDecoder().decode(EnterGroupResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func addHouseworkSchedule(_ groupId: Int, _ requestDTO: AddHouseworkScheduleRequestDTO) async throws -> EnterGroupResponseDTO {
        let response = try await provider.request(.addHouseworkSchedule(groupId: groupId, requestDTO: requestDTO))
        let responseDTO = try JSONDecoder().decode(EnterGroupResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getPlaceList(_ groupId: Int) async throws -> GetPlaceListResponseDTO {
        let response = try await provider.request(.getPlaceList(groupId: groupId))
        let responseDTO = try JSONDecoder().decode(GetPlaceListResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func addPlace(_ groupId: Int, placeName: String) async throws {
        try await provider.request(.addPlace(groupId: groupId, placeName: placeName))
    }
    
    func getTagList(_ groupId: Int) async throws -> GetTagResponseDTO {
        let response = try await provider.request(.getTags(groupId: groupId))
        let responseDTO = try JSONDecoder().decode(GetTagResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func addTag(_ groupId: Int, tagName: String) async throws -> AddTagResponseDTO {
        let response = try await provider.request(.addTag(groupId: groupId, tagName: tagName))
        let responseDTO = try JSONDecoder().decode(AddTagResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMemberList(_ groupId: Int) async throws -> GetGroupMemberResponseDTO {
        let response = try await provider.request(.getMemberList(groupId: groupId))
        let responseDTO = try JSONDecoder().decode(GetGroupMemberResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func postKakaoLogin(_ accessToken: String) async throws -> PostKakaoLoginResponseDTO {
        let requestDTO = PostKakaoLoginRequestDTO(accessToken: accessToken)
        let response = try await provider.request(.postKakaoLogin(requestDTO: requestDTO))
        let responseDTO = try JSONDecoder().decode(PostKakaoLoginResponseDTO.self, from: response)
        dump(responseDTO)
        UserDefaultsService.isSignedIn = true // 로그인 상태로 변경
        return responseDTO
    }
    
    func getPresetHouseworkList() async throws -> GetHouseworkPresetListDTO {
        let response = try await provider.request(.getPresetHouseworkList)
        let responseDTO = try JSONDecoder().decode(GetHouseworkPresetListDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyGroup() async throws -> GetMyGroupResponseDTO {
        let response = try await provider.request(.getMyGroup)
        let responseDTO = try JSONDecoder().decode(GetMyGroupResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getHaveHousework(_ groupId: Int, from: String, to: String) async throws -> GetHaveHouseworkResponseDTO {
        let response = try await provider.request(.getHaveHousework(groupId: groupId, from: from, to: to))
        let responseDTO = try JSONDecoder().decode(GetHaveHouseworkResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getHouseworkList(_ groupId: Int, date: String) async throws -> GetHouseworkResponseDTO {
        let response = try await provider.request(.getHouseworkList(groupId: groupId, date: date))
        let responseDTO = try JSONDecoder().decode(GetHouseworkResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func completeHousework(_ houseworkId: Int) async throws {
        try await provider.request(.completeHousework(houseworkId: houseworkId))
    }
    
    func sendEmotionCard(_ requestDTO: SendEmotionRequestDTO) async throws -> SendEmotionCardResponseDTO {
        let response = try await provider.request(.sendEmotionCard(requestDTO: requestDTO))
        let responseDTO = try JSONDecoder().decode(SendEmotionCardResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getEmotionCardDetail(_ emotionCardId: Int) async throws -> GetEmotionCardResponseDTO {
        let response = try await provider.request(.getEmotionCard(emotionCardId: emotionCardId))
        let responseDTO = try JSONDecoder().decode(GetEmotionCardResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
        
    func getMyRecentHouseworkList(_ groupId: Int, receiverId: Int) async throws -> GetMyRecentHouseworkResponseDTO {
        let response = try await provider.request(.getRecentWeekHouseworkList(groupId: groupId, receiverId: receiverId))
        let responseDTO = try JSONDecoder().decode(GetMyRecentHouseworkResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func deleteHousework(_ houseworkId: Int) async throws {
        try await provider.request(.deleteHousework(houseworkId: houseworkId))
    }
    
    func getHouseworkDetail(_ houseworkId: Int) async throws -> GetHouseworkDetailResponseDTO {
        let response = try await provider.request(.getHouseworkDetail(houseworkId: houseworkId))
        let responseDTO = try JSONDecoder().decode(GetHouseworkDetailResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getEmotionCardList(from: String, to: String, sorted: String) async throws -> GetEmotionCardListResponseDTO {
        let response = try await provider.request(.getEmotionCardList(from: from, to: to, sorted: sorted))
        let responseDTO = try JSONDecoder().decode(GetEmotionCardListResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getCleanliness(_ groupId: Int) async throws -> GetCleanlinessResponseDTO {
        let response = try await provider.request(.getCleanliness(groupId: groupId))
        let responseDTO = try JSONDecoder().decode(GetCleanlinessResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getTodayPlaceHousework(_ groupId: Int) async throws -> GetTodayPlaceHouseworkResponseDTO {
        let response = try await provider.request(.getTodayPlaceHousework(placeId: groupId))
        let responseDTO = try JSONDecoder().decode(GetTodayPlaceHouseworkResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyContribution(_ groupId: Int) async throws -> GetMyContributionResponseDTO {
        let response = try await provider.request(.getMyContribution(groupId: groupId))
        let responseDTO = try JSONDecoder().decode(GetMyContributionResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyTodayCompletionStatus() async throws -> GetMyTodayCompletionStatusResponseDTO {
        let response = try await provider.request(.getMyTodayCompletionStatus)
        let responseDTO = try JSONDecoder().decode(GetMyTodayCompletionStatusResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyWeekCompletionStatus() async throws -> GetMyWeekCompletionStatusResponseDTO {
        let response = try await provider.request(.getMyWeekCompletionStatus)
        let responseDTO = try JSONDecoder().decode(GetMyWeekCompletionStatusResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyTwoWeeksCompletionStatusComparison() async throws -> GetMyTwoWeeksCompletionStatusComparisonResponseDTO {
        let response = try await provider.request(.getMyWeekCompletionStatus)
        let responseDTO = try JSONDecoder().decode(GetMyTwoWeeksCompletionStatusComparisonResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
    
    func getMyEmotionCardAndCompletionStatus() async throws -> GetMyEmotionCardAndCompletionStatusResponseDTO {
        let response = try await provider.request(.getMyEmotionCardAndCompletionStatus)
        let responseDTO = try JSONDecoder().decode(GetMyEmotionCardAndCompletionStatusResponseDTO.self, from: response)
        dump(responseDTO)
        return responseDTO
    }
}
