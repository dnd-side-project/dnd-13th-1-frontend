//
//  GetTodayPlaceHouseworkResponseDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/25/25.
//

import Foundation

struct GetTodayPlaceHouseworkResponseDTO: Decodable {
    let myHouseWork: [HouseWork]
    let ourHouseWork: [HouseWork]
    struct HouseWork: Decodable {
        let houseWorkId: Int
        let houseWorkTitle: String
        let houseWorkMembers: [Member]
        struct Member: Decodable {
            let memberId: Int
            let memberProfileImageUrl: String?
        }
    }
}
