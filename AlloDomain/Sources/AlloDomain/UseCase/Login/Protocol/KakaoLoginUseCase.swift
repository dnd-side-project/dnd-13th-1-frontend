//
//  KakaoLoginUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation

public protocol KakaoLoginUseCase: Sendable {
    func execute() async throws -> Token
}
