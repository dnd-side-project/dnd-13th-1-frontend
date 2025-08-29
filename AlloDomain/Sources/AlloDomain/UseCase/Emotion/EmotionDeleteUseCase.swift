//
//  EmotionDeleteUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/29/25.
//

import Foundation

public protocol EmotionDeleteUseCase: Sendable {
    func execute(_ emotion: Int) async throws
}

