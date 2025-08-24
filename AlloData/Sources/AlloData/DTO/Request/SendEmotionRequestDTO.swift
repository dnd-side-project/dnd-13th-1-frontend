//
//  SendEmotionRequestDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

struct SendEmotionRequestDTO: Codable {
    let receiverId: Int
    let houseWorkId: Int
    let disappointment: String
    let compliments: [String]
}
