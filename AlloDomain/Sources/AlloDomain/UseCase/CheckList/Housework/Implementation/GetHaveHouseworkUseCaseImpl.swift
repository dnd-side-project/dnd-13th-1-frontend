//
//  GetHaveHouseworkUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

final class GetHaveHouseworkUseCaseImpl {
    private let houseworkRepository: HouseworkRepository
    init(houseworkRepository: HouseworkRepository) {
        self.houseworkRepository = houseworkRepository
    }
}

extension GetHaveHouseworkUseCaseImpl: GetHaveHouseworkUseCase {
    func execute(from: Date, to: Date) async throws -> [Date : Bool] {
        try await houseworkRepository.getHaveHousework(from: from, to: to)
    }
}
