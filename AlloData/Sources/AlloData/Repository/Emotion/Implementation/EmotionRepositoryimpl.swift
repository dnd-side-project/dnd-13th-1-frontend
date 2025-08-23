//
//  EmotionRepositoryimpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class EmotionRepositoryimpl: EmotionRepository {
    // TODO: Service 의존성 추가
    func getEmotionList(filter: String, sorted: String) async throws -> [EmotionList] {
        return []
    }
    func sendHouseworkEmotion() async throws -> [SendEmotion] {
        return []
    }
}
