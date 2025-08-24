//
//  AIUseCase.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public protocol AIUseCase: Sendable {
    func transformMessage(_ text: String) async throws -> String
}
