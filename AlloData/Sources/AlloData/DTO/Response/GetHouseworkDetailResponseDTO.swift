//
//  GetHouseworkDetailResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetHouseworkDetailResponseDTO: Decodable {
    let houseWorkId: Int
    let houseWorkTitle: String
    let houseWorkTag: [Tag]
    let houseWorkDate: String
    let houseWorkMembers: [Member]
    
    struct Tag: Decodable {
        let name: String
    }
    
    struct Member: Decodable {
        let memberId: Int
        let memberNickName: String
    }
}
