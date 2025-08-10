//
//  GetHouseworkListUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

final class GetHouseworkListUseCaseImpl {
    private let houseworkRepository: HouseworkRepository
    init(houseworkRepository: HouseworkRepository) {
        self.houseworkRepository = houseworkRepository
    }
}

extension GetHouseworkListUseCaseImpl: GetHouseworkListUseCase {
    func execute(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    ) {
        try await houseworkRepository.getHouseworkList(date)
    }
}
