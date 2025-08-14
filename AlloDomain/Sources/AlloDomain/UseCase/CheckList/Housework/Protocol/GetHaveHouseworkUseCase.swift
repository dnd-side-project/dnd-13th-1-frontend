//
//  GetHaveHouseworkUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public protocol GetHaveHouseworkUseCase: Sendable {
    func execute(from: Date, to: Date) async throws -> [Date: Bool]

}
