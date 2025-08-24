//
//  AddHouseworkScheduleRequestDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

struct AddHouseworkScheduleRequestDTO: Codable {
    let houseWorkName: String
    let placeId: Int
    let tags: [Int]
    let members: [Int]
    let startDate: String
    let dueDate: String
    let routinePolicy: String
    let dayOfTheWeek: [String]
    let isNotified: Bool
}
