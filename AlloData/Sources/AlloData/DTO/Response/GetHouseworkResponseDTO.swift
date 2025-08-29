//
//  GetHouseworkResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

struct GetHouseworkResponseDTO: Decodable {
    let myHouseWorkLeft: [Housework]
    let ourHouseWorkLeft: [Housework]
    let myHouseWorkCompleted: [Housework]
    let ourHouseWorkCompleted: [Housework]
    
    struct Housework: Decodable {
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
            let memberProfileImageUrl: String?
        }
    }
}
