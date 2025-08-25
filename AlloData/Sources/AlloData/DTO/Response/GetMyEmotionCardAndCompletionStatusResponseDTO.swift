//
//  GetMyEmotionCardAndCompletionStatusResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetMyEmotionCardAndCompletionStatusResponseDTO: Decodable {
    let receivedEmotionCardCount: Int
    let sentEmotionCardCount: Int
    let completedHouseWorkCount: Int
}
