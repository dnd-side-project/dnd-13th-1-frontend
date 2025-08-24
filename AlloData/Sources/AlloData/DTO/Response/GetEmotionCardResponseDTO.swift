//
//  GetEmotionCardResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

struct GetEmotionCardResponseDTO: Decodable {
    let emotionCardId: Int
    let houseWorkName: String
    let compliments: [String]
    let disappointment: String
    let senderNickName: String
    let receiverNickName: String
    let createdTime: String
}
