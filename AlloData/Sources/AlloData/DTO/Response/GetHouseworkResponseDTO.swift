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
        let houseworkId: Int
        let houseworkTitle: String
        let houseworkTag: [String]
        let houseworkDate: String
        let houseworkMembers: [Member]
        
        struct Member: Decodable {
            let memberId: Int
            let memberNickName: String
            let memberProfileImageUrl: String?
        }
    }
}
