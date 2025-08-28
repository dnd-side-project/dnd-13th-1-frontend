//
//  EmotionDetailUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/26/25.
//

import Foundation

public protocol EmotionDetailUseCase: Sendable {
    func execute(id: Int) async throws -> EmotionDetail
}
