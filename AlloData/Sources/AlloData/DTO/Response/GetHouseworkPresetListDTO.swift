//
//  GetHouseworkPresetListDTO.swift
//  AlloData
//
//  Created by 황채웅 on 8/24/25.
//

import Foundation

typealias GetHouseworkPresetListDTO = [GetHouseworkPresetListDTOElement]

struct GetHouseworkPresetListDTOElement: Decodable {
    let houseWorkCatId: Int
    let catName: String
    let houseworks: [HouseWork]
    
    struct HouseWork: Decodable {
        let houseWorkId: Int
        let name: String
    }
}
