//
//  HouseworkRepository.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public protocol HouseworkRepository: Sendable {
    func getHaveHousework(from: Date, to: Date) async throws -> [Date: Bool]
    func getHouseworkList(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    )
    func completeHousework(_ housework: Housework) async throws
    func addHousework(_ housework: Housework) async throws
    func deleteHousework(_ housework: Housework) async throws
}
