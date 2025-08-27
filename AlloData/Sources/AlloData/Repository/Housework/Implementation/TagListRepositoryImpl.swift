//
//  TagListRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/26/25.
//

//import Foundation
//import AlloDomain
//
//final class TagListRepositoryImpl: TagListRepository {
//    private let networkService: NetworkService
//    
//    init(networkService: NetworkService) {
//        self.networkService = networkService
//    }
//    
//    func getTagList(groupId: Int) async throws -> [TagList] {
//        let dto = try await networkService.getTagList(groupId)
//        return dto.map { TagList(tagId: $0.tagId, name: $0.name) }
//    }
//}
import Foundation
import AlloDomain

final class TagListRepositoryImpl: TagListRepository {
    func getTagList(groupId: Int) async throws -> [TagList] {
        // 더미 데이터 생성
        let dummyTags: [TagList] = [
            TagList(tagId: 1, name: "바닥 청소기 돌리기"),
            TagList(tagId: 2, name: "쓰레기통 비우기"),
            TagList(tagId: 3, name: "창문 닦기"),
            TagList(tagId: 4, name: "책상 정리하기")
        ]
        return dummyTags
    }
}
