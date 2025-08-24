//
//  GetMyTwoWeeksCompletionStatusComparisonResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetMyTwoWeeksCompletionStatusComparisonResponseDTO: Decodable {
    let twoWeeksAgoCompleted: Int
    let lastWeekCompleted: Int
}
