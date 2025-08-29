//
//  AlloAPI.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import Moya

enum AlloAPI {
    case createGroup(backGroundTypeNum: Int) // 그룹 생성
    case enterGroup(inviteCode: String) // 그룹 입장
    case addHouseworkSchedule(groupId: Int, requestDTO: AddHouseworkScheduleRequestDTO) // 집안일 일정 추가
    case getPlaceList(groupId: Int) // 그룹 장소 목록 조회
    case addPlace(groupId: Int, placeName: String) // 장소 추가
    case getTags(groupId: Int) // 그룹 태그 목록 조회
    case addTag(groupId: Int, tagName: String) // 그룹 태그 추가
    case getMemberList(groupId: Int) // 그룹 멤버 조회
    case postKakaoLogin(requestDTO: PostKakaoLoginRequestDTO) // 로그인
    case getPresetHouseworkList // 프리셋 집안일 목록 조회
    case getMyGroup // 사용자 그룹 조회
    case getHaveHousework(groupId: Int, from: String, to: String) // 기간내 집안일 존재여부 조회
    case getHouseworkList(groupId: Int, date: String) // 특정 날짜의 집안일 목록 조회
    case completeHousework(houseworkId: Int) // 특정 집안일 완료
    case sendEmotionCard(requestDTO: SendEmotionRequestDTO) // 마음 보내기
    case deleteEmotion(emotionCardId: Int) // 특정 마음카드 삭제
    case getEmotionCard(emotionCardId: Int) // 마음 카드 상세 조회
    case getRecentWeekHouseworkList(groupId: Int, receiverId: Int) // 사용자의 오늘 기점 최근 7일간 집안일 조회
    case deleteHousework(houseworkId: Int) // 특정 집안일 삭제
    case getHouseworkDetail(houseworkId: Int) // 집안일 상세 조회
    //    case editHousework(houseworkId: Int) // 특정 집안일 편집
    case getEmotionCardList(filter: String, sorted: String) // 내 마음카드 목록 조회
    //    case getCharacterStatus(groupId: Int) // 그룹 캐릭터 상태 조회
    case getCleanliness(groupId: Int) // 홈/우리집 청결도 조회
    case getGroupState(groupId: Int) // 홈/우리집 청결도, 캐릭터 상태, 대사 조회
    case getTodayPlaceHousework(placeId: Int) // 홈/특정 장소의 오늘의 할 일 조회
    case getMyContribution(groupId: Int) // 마이/나의 기여도 조회
    case getMyTodayCompletionStatus // 마이/나의 오늘의 집안일 완수 상태 조회
    case getMyWeekCompletionStatus // 마이/나의 지난 일주일 간 집안일 완수 상태 조회
    case getMyTwoWeekCompletionStatusComparison // 마이/나의 2주 전, 1주 전 완수 상태 비교 조회
    case getMyEmotionCardAndCompletionStatus // 마이/나의 받은 칭찬, 보낸 칭찬, 완수 집안일 수
    case getMyProfile // 내 프로필 조회
    case patchMyProfile(requestDTO: PatchProfileRequestDTO)// 내 프로필 수정
}

extension AlloAPI: TargetType {
    var accessToken: String {
        guard let token = try? KeychainService.get(key: "accessToken") else {
            return ""
        }
        return token
    }
    
    var baseURL: URL {
        guard let baseURLString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let baseURL = URL(string: baseURLString) else {
            fatalError("BASE URL 불러오기 실패")
        }
        return baseURL
    }
    
    var path: String {
        return switch self {
        case .createGroup:
            "/api/groups"
        case .enterGroup:
            "/api/groups/enter"
        case let .addHouseworkSchedule(groupId, _):
            "/api/groups/\(groupId)/house-work"
        case let .getPlaceList(groupId):
            "/api/groups/\(groupId)/places"
        case let .addPlace(groupId, _):
            "/api/groups/\(groupId)/places"
        case .getTags(groupId: let groupId):
            "/api/groups/\(groupId)/tags"
        case let .addTag(groupId, _):
            "/api/groups/\(groupId)/tags"
        case let .getMemberList(groupId):
            "/api/groups/\(groupId)/members"
        case .postKakaoLogin:
            "/api/auth/login"
        case .getPresetHouseworkList:
            "/api/preset/house-work"
        case .getMyGroup:
            "/api/groups/my-group"
        case let .getHaveHousework(groupId, _, _):
            "/api/groups/\(groupId)/my-house-work/period"
        case let .getHouseworkList(groupId, _):
            "/api/groups/\(groupId)/my-house-work/date"
        case let .completeHousework(houseworkId):
            "/api/groups/house-work/\(houseworkId)/complete"
        case .sendEmotionCard:
            "/api/emotion-cards"
        case let .getEmotionCard(emotionCardId):
            "/api/emotion-cards/\(emotionCardId)"
        case let .getRecentWeekHouseworkList(groupId, _):
            "/api/groups/\(groupId)/house-work/recent"
        case let .deleteHousework(houseworkId):
            "/api/groups/house-work/\(houseworkId)"
        case let .getHouseworkDetail(houseworkId):
            "/api/groups/house-work/\(houseworkId)"
        case .getEmotionCardList:
            "/api/emotion-cards/my-emotion-card"
        case let .getCleanliness(groupId):
            "/api/groups/\(groupId)/cleanliness"
        case let .getGroupState(groupId):
            "/api/groups/\(groupId)/state"
        case let .getTodayPlaceHousework(placeId):
            "/api/groups/places/\(placeId)/house-work"
        case let .getMyContribution(groupId):
            "/api/groups/\(groupId)/house-work/me/contribution"
        case .getMyTodayCompletionStatus:
            "/api/groups/house-work/me/today"
        case .getMyWeekCompletionStatus:
            "/api/groups/house-work/me/week"
        case .getMyTwoWeekCompletionStatusComparison:
            "/api/groups/house-work/me/comparison"
        case .getMyEmotionCardAndCompletionStatus:
            "api/groups/house-work/me/activity-summary"
        case .getMyProfile:
            "auth/user/me"
        case .patchMyProfile:
            "auth/user/me"
        case let .deleteEmotion(emotionCardId):
            "/api/emotion-cards/\(emotionCardId)"
        }
    }
    
    var method: Moya.Method {
        return switch self {
        case .createGroup:
                .post
        case .enterGroup:
                .post
        case .addHouseworkSchedule:
                .post
        case .getPlaceList:
                .get
        case .addPlace:
                .post
        case .getTags:
                .get
        case .addTag:
                .post
        case .getMemberList:
                .get
        case .postKakaoLogin:
                .post
        case .getPresetHouseworkList:
                .get
        case .getMyGroup:
                .get
        case .getHaveHousework:
                .get
        case .getHouseworkList:
                .get
        case .completeHousework:
                .put
        case .sendEmotionCard:
                .post
        case .getEmotionCard:
                .get
        case .getRecentWeekHouseworkList:
                .get
        case .deleteHousework:
                .delete
        case .getHouseworkDetail:
                .get
        case .getEmotionCardList:
                .get
        case .getCleanliness:
                .get
        case .getGroupState:
                .get
        case .getTodayPlaceHousework:
                .get
        case .getMyContribution:
                .get
        case .getMyTodayCompletionStatus:
                .get
        case .getMyWeekCompletionStatus:
                .get
        case .getMyTwoWeekCompletionStatusComparison:
                .get
        case .getMyEmotionCardAndCompletionStatus:
                .get
        case .getMyProfile:
                .get
        case .patchMyProfile:
                .patch
        case .deleteEmotion:
                .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .createGroup(backGroundTypeNum):
            return .requestJSONEncodable(["backGroundTypeNum": backGroundTypeNum])
        case let .enterGroup(inviteCode):
            return .requestJSONEncodable(["inviteCode": inviteCode])
        case let .addHouseworkSchedule(_, requestDTO):
            return .requestJSONEncodable(requestDTO)
        case .getPlaceList:
            return .requestPlain
        case let .addPlace(_, name):
            return .requestJSONEncodable(["name": name])
        case .getTags:
            return .requestPlain
        case let .addTag(_, tagName):
            return .requestJSONEncodable(["tagName": tagName])
        case .getMemberList:
            return .requestPlain
        case let .postKakaoLogin(requestDTO):
            return .requestJSONEncodable(requestDTO)
        case .getPresetHouseworkList:
            return .requestPlain
        case .getMyGroup:
            return .requestPlain
        case let .getHaveHousework(_, from, to):
            return .requestParameters(parameters: ["from": from, "to": to], encoding: URLEncoding.queryString)
        case let .getHouseworkList(_, date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .completeHousework:
            return .requestPlain
        case let .sendEmotionCard(requestDTO):
            return .requestJSONEncodable(requestDTO)
        case .getEmotionCard:
            return .requestPlain
        case let .getRecentWeekHouseworkList(_, receiverId):
            return .requestParameters(parameters: ["receiverId": receiverId], encoding: URLEncoding.queryString)
        case .deleteHousework:
            return .requestPlain
        case .getHouseworkDetail:
            return .requestPlain
        case let .getEmotionCardList(filter, sorted):
            return .requestParameters(parameters: ["filter": filter, "sorted": sorted], encoding: URLEncoding.queryString)
        case .getCleanliness:
            return .requestPlain
        case .getGroupState:
            return .requestPlain
        case .getTodayPlaceHousework:
            return .requestPlain
        case .getMyContribution:
            return .requestPlain
        case .getMyTodayCompletionStatus:
            return .requestPlain
        case .getMyWeekCompletionStatus:
            return .requestPlain
        case .getMyTwoWeekCompletionStatusComparison:
            return .requestPlain
        case .getMyEmotionCardAndCompletionStatus:
            return .requestPlain
        case .getMyProfile:
            return .requestPlain
        case let .patchMyProfile(requestDTO):
//            let imageData = requestDTO.profileImage.pngData() ?? Data()
//            let userIdData = "\(requestDTO.nickname)".data(using: .utf8) ?? Data()
//            
//            var formData: [Moya.MultipartFormData] = []
//            
//            formData.append(Moya.MultipartFormData(
//                provider: .data(userIdData),
//                name: "nickname"
//            ))
//            formData.append(Moya.MultipartFormData(
//                provider: .data(imageData),
//                name: "profileImage",
//                fileName: "profile.png",
//                mimeType: "image/png"
//            ))
//            return .uploadMultipart(formData)
            return .requestJSONEncodable(requestDTO)
        case .deleteEmotion:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        /// 기본 엔드포인트에 적용
        let withAuthorization = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        /// 사진 등 Multipart FormData 엔드포인트에 적용
        let multipartFormDatawithAuthorization = [
            "Authorization": "\(accessToken)",
            "Content-Type": "multipart/form-data"
        ]
        /// 로그인 등 Auth 관련 엔드포인트에 적용
        let withNoAuthorization = [
            "Content-Type": "application/json"
        ]
        return switch self {
        case .postKakaoLogin:
            withNoAuthorization
        default:
            withAuthorization
        }
    }
}
