//
//  GetPlaceListResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

typealias GetPlaceListResponseDTO = [GetPlaceListResponseDTOElement]

struct GetPlaceListResponseDTOElement: Decodable {
    let placeId: Int
    let name: String
}
