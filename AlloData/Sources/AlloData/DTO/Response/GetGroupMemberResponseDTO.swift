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
    let memberNickName: String
    let memberProfileImageUrl: String?
}
