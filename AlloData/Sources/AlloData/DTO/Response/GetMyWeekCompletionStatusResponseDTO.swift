//
//  GetMyWeekCompletionStatusResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetMyWeekCompletionStatusResponseDTO: Decodable {
    let completed: Int
    let total: Int
    let weeklyCompleted: WeeklyCompletionStatus
    struct WeeklyCompletionStatus: Decodable {
        let monday: Int
        let tuesday: Int
        let wednesday: Int
        let thursday: Int
        let friday: Int
        let saturday: Int
        let sunday: Int
    }
}
