//
//  AlloAPI.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import Moya

enum AlloAPI {
    case postKakaoLogin(requestDTO: PostKakaoLoginRequestDTO)
}

extension AlloAPI: TargetType {
    
    var accessToken: String? {
        try? KeychainService.get(key: "accessToken")
    }
    
    var baseURL: URL {
        guard let baseURLString = Bundle.main.infoDictionary?["BASE_URL"] as? String
            else { fatalError("Base URL을 불러올 수 없습니다.") }
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Base URL이 올바르지 않습니다.")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .postKakaoLogin:
            "/login/kakao"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postKakaoLogin:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postKakaoLogin(requestDTO):
            .requestJSONEncodable(requestDTO)
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
        switch self {
        case .postKakaoLogin:
            return withNoAuthorization
        }
    }
}
