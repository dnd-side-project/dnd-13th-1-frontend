//
//  AddHouseworkUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

final class AddHouseworkUseCaseImpl {
    private let houseworkRepository: HouseworkRepository
    init(houseworkRepository: HouseworkRepository) {
        self.houseworkRepository = houseworkRepository
    }
}

extension AddHouseworkUseCaseImpl: AddHouseworkUseCase {
    func execute(housework: Housework) async throws {
        return try await houseworkRepository.addHousework(housework: housework)
    }
}
