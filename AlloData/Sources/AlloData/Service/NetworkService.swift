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
struct NetworkService {
    
    private func logout() {
        try? KeychainService.delete(key: "accessToken")
        UserDefaultsService.isSignedIn = false
    }
    
    private let provider = MoyaProvider<AlloAPI>()
        
    func postKakaoLogin(_ accessToken: String) async throws -> PostKakaoLoginResponseDTO {
        let requestDTO = PostKakaoLoginRequestDTO(accessToken: accessToken)
        let response = try await provider.request(.postKakaoLogin(requestDTO: requestDTO))
        let responseDTO = try JSONDecoder().decode(PostKakaoLoginResponseDTO.self, from: response)
        UserDefaultsService.isSignedIn = true // 로그인 상태로 변경
        return responseDTO
    }
}
