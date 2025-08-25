//
//  GetEmotionCardListResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

typealias GetEmotionCardListResponseDTO = [GetEmotionCardListResponseDTOElement]

struct GetEmotionCardListResponseDTOElement: Decodable {
    let emotionCardId: Int
    let houseWorkName: String
    let content: String
    let senderNickName: String
    let receiverNickName: String
    let createdTime: String
    let emotionType: String
}
