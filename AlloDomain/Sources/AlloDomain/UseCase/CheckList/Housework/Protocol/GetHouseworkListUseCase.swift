//
//  GetHouseworkListUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public protocol GetHouseworkListUseCase: Sendable {
    func execute(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    )
}
