//
//  CreateGroupResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

struct CreateGroupResponseDTO: Decodable {
    let groupId: Int
    let inviteCode: String
}
