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
    
    func fetchMembers() async throws -> [Member] {
        guard let groupId = UserDefaultsService.groupId else { return [] }
        let dto = try await networkService.getMemberList(groupId)
        return dto.compactMap { element in
            guard let urlString = element.memberProfileImageUrl,
                  let url = URL(string: urlString) else {
                return Member(id: element.memberId, name: element.memberNickName, profileImageUrl: nil)
            }
            return Member(id: element.memberId, name: element.memberNickName, profileImageUrl: url)
        }
    }

    func patchMyProfile(nickname: String, imageData: Data) async throws {
//        let requestDTO = PatchProfileRequestDTO(nickname: nickname, profileImage: UIImage(data: imageData) ?? UIImage())
        let requestDTO = PatchProfileRequestDTO(nickname: nickname)
        try await networkService.patchMyProfile(requestDTO)
    }
}
