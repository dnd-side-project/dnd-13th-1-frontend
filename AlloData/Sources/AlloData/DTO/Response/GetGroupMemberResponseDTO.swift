//
//  GetGroupMemberResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

typealias GetGroupMemberResponseDTO = [GetGroupMemberResponseDTOElement]

struct GetGroupMemberResponseDTOElement: Decodable {
    let memberId: Int
    let name: String
    let profileImageUrl: String?
}
