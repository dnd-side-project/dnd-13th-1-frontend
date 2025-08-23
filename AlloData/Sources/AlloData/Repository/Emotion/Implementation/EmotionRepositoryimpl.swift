//
//  EmotionRepositoryimpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class EmotionRepositoryimpl: EmotionRepository  {
    func getEmotionList() async throws -> [AlloDomain.EmotionList] {
        return []
    }
    
    // TODO: Service 의존성 추가
    public func sendHouseworkEmotion() async throws -> [SendEmotion] {
        return [
        ]
    }
}
