//
//  GetHaveHouseworkResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

typealias GetHaveHouseworkResponseDTO = [GetHaveHouseworkResponseDTOElement]

struct GetHaveHouseworkResponseDTOElement: Decodable {
    let date: String
    let hasHouseWork: Bool
}
