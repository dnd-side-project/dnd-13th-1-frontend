//
//  GetMyTodayCompletionStatusResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetMyTodayCompletionStatusResponseDTO: Decodable {
    let completed: Int
    let left: Int
}
