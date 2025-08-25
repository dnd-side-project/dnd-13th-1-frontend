//
//  GetMyRecentHouseworkResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

typealias GetMyRecentHouseworkResponseDTO = [GetMyRecentHouseworkResponseDTOElement]

struct GetMyRecentHouseworkResponseDTOElement: Decodable {
    let date: String
    let houseWorks: [Housework]
    struct Housework: Decodable {
        let placeName: String
        let houseWorkId: Int
        let houseWorkName: String
    }
}
