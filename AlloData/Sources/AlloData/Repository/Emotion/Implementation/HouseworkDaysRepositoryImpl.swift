//
//  HouseworkDaysRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class HouseworkDaysRepositoryImpl: HouseworkDaysRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func fetchSevenDaysHousework(receiverId: Int) async throws -> [HouseworkSevendays] {
        guard let groupId = UserDefaultsService.groupId else {
            print("[HouseworkDaysRepositoryImpl] groupId is nil")
            return []
        }
        
        let response: GetMyRecentHouseworkResponseDTO =
        try await networkService.getMyRecentHouseworkList(groupId, receiverId: receiverId)
        
        return response.map { dto in
            let date =  dto.date// string 타입
            let houseWorks = dto.houseWorks.map { hw in
                HouseworkRecent(
                    id: hw.houseWorkId,
                    place: hw.placeName,
                    title: hw.houseWorkName
                )
            }
            return HouseworkSevendays(date: date, houseWorks: houseWorks)
        }
    }
}
