//
//  KakaoLoginRepository.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation

public protocol KakaoLoginRepository: Sendable {
    func kakaoLogin() async throws -> Token
}
