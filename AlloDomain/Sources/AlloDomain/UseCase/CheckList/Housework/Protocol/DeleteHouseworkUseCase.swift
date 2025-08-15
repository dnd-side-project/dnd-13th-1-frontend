//
//  DeleteHouseworkUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public protocol DeleteHouseworkUseCase {
    func execute(_ housework: Housework) async throws
}
