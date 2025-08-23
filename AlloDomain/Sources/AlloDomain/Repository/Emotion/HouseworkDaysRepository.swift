//
//  HouseworkDaysRepository.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation

public protocol HouseworkDaysRepository: Sendable {
    func fetchSevenDaysHousework() async throws -> [HouseworkSevendays]
}

