//
//  GetHouseworkDetailResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetHouseworkDetailResponseDTO: Decodable {
    let houseworkId: Int
    let houseworkTitle: String
    let houseworkTag: [Tag]
    let houseworkDate: String
    let houseworkMembers: [Member]
    
    struct Tag: Decodable {
        let name: String
    }
    
    struct Member: Decodable {
        let memberId: Int
        let memberNickName: String
    }
}
