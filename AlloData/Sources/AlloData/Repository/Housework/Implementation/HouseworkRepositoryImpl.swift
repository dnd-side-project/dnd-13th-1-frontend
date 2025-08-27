//
//  HouseworkRepositoryImpl.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

final class HouseworkRepositoryImpl: HouseworkRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getHaveHousework(from: Date, to: Date) async throws -> [Date : Bool] {
        return [:]
    }
    
    func getHouseworkList(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    ) {
        return (
            myHouseworksLeft: [],
            ourHouseworksLeft: [],
            myHouseworksCompleted: [],
            ourHouseworksCompleted: []
        )
    }
    
    func completeHousework(_ housework: Housework) async throws {
        
    }
    
    func addHousework(groupId: Int, housework: Housework) async throws {
        let requestDTO = AddHouseworkScheduleRequestDTO(
            houseWorkName: housework.houseWorkName,
            placeId: housework.placeAdd,
            tags: housework.tagsAdd,
            members: housework.members,
            startDate: housework.startDate,
            dueDate: housework.dueDate,
            routinePolicy: housework.routineAdd.rawValue,
            dayOfTheWeek: housework.dayOfTheWeek.map { $0.rawValue },
            isNotified: housework.isNotified
        )
        _ = try await networkService.addHouseworkSchedule(groupId, requestDTO)
    }
    
    func deleteHousework(_ housework: Housework) async throws {
        
    }
}
