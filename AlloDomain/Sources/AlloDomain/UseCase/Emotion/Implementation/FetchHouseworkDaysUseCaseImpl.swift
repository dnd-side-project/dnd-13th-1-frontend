//
//  FetchHouseworkDaysUseCaseImpl.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

final class FetchHouseworkDaysUseCaseImpl {
    private let houseworkDaysRepository: HouseworkDaysRepository
    init(houseworkDaysRepository: HouseworkDaysRepository) {
        self.houseworkDaysRepository = houseworkDaysRepository
    }
}

extension FetchHouseworkDaysUseCaseImpl: FetchHouseworkDaysUseCase {
    public func execute() async throws -> [HouseworkSevendays] {
        return try await houseworkDaysRepository.fetchSevenDaysHousework()
    }
}

