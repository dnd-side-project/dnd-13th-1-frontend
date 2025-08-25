//
//  KakaoLoginRepositoryImpl.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import Moya
import AlloDomain
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLoginRepositoryImpl: KakaoLoginRepository {
    
    enum KakaoLoginError: Error {
        case tokenNotFound
        case loginNotAvailable
    }
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func kakaoLogin() async throws -> AlloDomain.Token {
        let accessToken = try await getKakaoLoginAccessToken()
        let responseDTO = try await networkService.postKakaoLogin(accessToken)
        try KeychainService.save(token: responseDTO.accessToken, key: "accessToken")
        return Token(accessToken: responseDTO.accessToken)
    }
    
    /// - 카카오톡에서 카카오 로그인 후 토큰 정보를 가져오는 메소드입니다.
    /// - 카카오 SDK의 UserApi.shared,loginWithKakaoTalk이 GCD 기반이기 때문에, Swift Concurrency 기반으로 관리하기 위해 accessToken을 받아오는 메소드를 작성해 매핑했습니다.
    @MainActor
    private func getKakaoLoginAccessToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let token = oauthToken?.accessToken {
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: KakaoLoginError.tokenNotFound)
                    }
                }
            } else {
                continuation.resume(throwing: KakaoLoginError.loginNotAvailable)
            }
        }
    }
}
