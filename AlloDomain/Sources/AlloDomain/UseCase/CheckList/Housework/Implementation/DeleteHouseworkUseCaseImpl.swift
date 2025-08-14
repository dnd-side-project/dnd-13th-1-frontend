//
//  DeleteHouseworkUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

final class DeleteHouseworkUseCaseImpl {
    private let houseworkRepository: HouseworkRepository
    init(houseworkRepository: HouseworkRepository) {
        self.houseworkRepository = houseworkRepository
    }
}

extension DeleteHouseworkUseCaseImpl: DeleteHouseworkUseCase {
    func execute(_ housework: Housework) async throws {
        try await houseworkRepository.deleteHousework(housework)
    }
}
