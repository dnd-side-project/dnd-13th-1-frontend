//
//  MemberRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/21/25.
//

import Foundation
import AlloDomain

final class MemberRepositoryImpl: MemberRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getMemberList(groupId: Int) async throws -> [Member] {
        let dto = try await networkService.getMemberList(groupId)
        return dto.compactMap { element in
            guard let urlString = element.profileImageUrl,
                  let url = URL(string: urlString) else {
                return nil
            }
            return Member(
                id: element.memberId,
                name: element.name,
                profileImageUrl: url
            )
        }
    }
}
