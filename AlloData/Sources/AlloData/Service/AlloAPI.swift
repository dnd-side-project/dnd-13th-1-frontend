//
//  AlloAPI.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import Moya

enum AlloAPI {
    case createGroup(characterId: Int) // 그룹 생성
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
    case getEmotionCard(emotionCardId: Int) // 마음 카드 상세 조회
    case getRecentWeekHouseworkList(groupId: Int, receiverId: Int) // 사용자의 오늘 기점 최근 7일간 집안일 조회
    case deleteHousework(houseworkId: Int) // 특정 집안일 삭제
    case getHouseworkDetail(houseworkId: Int) // 집안일 상세 조회
    //    case editHousework(houseworkId: Int) // 특정 집안일 편집
    case getEmotionCardList(filter: String, sorted: String) // 내 마음카드 목록 조회
    //    case getCharacterStatus(groupId: Int) // 그룹 캐릭터 상태 조회
    case getCleanliness(groupId: Int) // 홈/우리집 청결도 조회
    case getTodayPlaceHousework(placeId: Int) // 홈/특정 장소의 오늘의 할 일 조회
    case getMyContribution(groupId: Int) // 마이/나의 기여도 조회
    case getMyTodayCompletionStatus // 마이/나의 오늘의 집안일 완수 상태 조회
    case getMyWeekCompletionStatus // 마이/나의 지난 일주일 간 집안일 완수 상태 조회
    case getMyTwoWeekCompletionStatusComparison // 마이/나의 2주 전, 1주 전 완수 상태 비교 조회
    case getMyEmotionCardAndCompletionStatus // 마이/나의 받은 칭찬, 보낸 칭찬, 완수 집안일 수
}

extension AlloAPI: TargetType {
    
    var accessToken: String? {
        return "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzU2Mzg3NDE0fQ.W8VsJFB9jbJw5BBeZTE1S1z0-_SyMip9NOClWLReMpw"
        //try? KeychainService.get(key: "accessToken")
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
        }
    }
    
    var task: Moya.Task {
        return switch self {
        case let .createGroup(characterId):
                .requestJSONEncodable(["characterId": characterId])
        case let .enterGroup(inviteCode):
                .requestJSONEncodable(["inviteCode": inviteCode])
        case let .addHouseworkSchedule(_, requestDTO):
                .requestJSONEncodable(requestDTO)
        case .getPlaceList:
                .requestPlain
        case let .addPlace(_, name):
                .requestJSONEncodable(["name": name])
        case .getTags:
                .requestPlain
        case let .addTag(_, tagName):
                .requestJSONEncodable(["tagName": tagName])
        case .getMemberList:
                .requestPlain
        case let .postKakaoLogin(requestDTO):
                .requestJSONEncodable(requestDTO)
        case .getPresetHouseworkList:
                .requestPlain
        case .getMyGroup:
                .requestPlain
        case let .getHaveHousework(_, from, to):
                .requestParameters(parameters: ["from": from, "to": to], encoding: URLEncoding.queryString)
        case let .getHouseworkList(_, date):
                .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .completeHousework:
                .requestPlain
        case let .sendEmotionCard(requestDTO):
                .requestJSONEncodable(requestDTO)
        case .getEmotionCard:
                .requestPlain
        case let .getRecentWeekHouseworkList(_, receiverId):
                .requestParameters(parameters: ["receiverId": receiverId], encoding: URLEncoding.queryString)
        case .deleteHousework:
                .requestPlain
        case .getHouseworkDetail:
                .requestPlain
        case let .getEmotionCardList(filter, sorted):
                .requestParameters(parameters: ["filter": filter, "sorted": sorted], encoding: URLEncoding.queryString)
        case .getCleanliness:
                .requestPlain
        case .getTodayPlaceHousework:
                .requestPlain
        case .getMyContribution:
                .requestPlain
        case .getMyTodayCompletionStatus:
                .requestPlain
        case .getMyWeekCompletionStatus:
                .requestPlain
        case .getMyTwoWeekCompletionStatusComparison:
                .requestPlain
        case .getMyEmotionCardAndCompletionStatus:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        /// 기본 엔드포인트에 적용
        let withAuthorization = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "Content-Type": "application/json"
        ]
        /// 사진 등 Multipart FormData 엔드포인트에 적용
        let multipartFormDatawithAuthorization = [
            "Authorization": "Bearer \(accessToken ?? "")",
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
