//
//  CompleteHouseworkUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

final class CompleteHouseworkUseCaseImpl {
    private let houseworkRepository: HouseworkRepository
    init(houseworkRepository: HouseworkRepository) {
        self.houseworkRepository = houseworkRepository
    }
}

extension CompleteHouseworkUseCaseImpl: CompleteHouseworkUseCase {
    func execute(_ housework: Housework) async throws {
        try await houseworkRepository.completeHousework(housework)
    }
}
