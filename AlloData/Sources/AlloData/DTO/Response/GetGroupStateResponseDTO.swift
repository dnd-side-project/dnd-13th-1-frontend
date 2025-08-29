//
//  GetGroupStateResponseDTO.swift
//  AlloData
//
//  Created by Assistant on 8/30/25.
//

import Foundation

struct GetGroupStateResponseDTO: Codable {
    let cleanliness: Int
    let state: String
    let message: String
}
