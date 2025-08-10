//
//  HouseworkRepositoryImpl.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

final class HouseworkRepositoryImpl: HouseworkRepository {
    // TODO: Service 의존성 추가
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
    
    func addHousework(_ housework: Housework) async throws {
        
    }
    
    func deleteHousework(_ housework: Housework) async throws {
        
    }
}
