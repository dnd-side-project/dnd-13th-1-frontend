//
//  GetTagResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

typealias GetTagResponseDTO = [GetTagResponseDTOElement]

struct GetTagResponseDTOElement: Decodable {
    let tagId: Int
    let name: String
}
