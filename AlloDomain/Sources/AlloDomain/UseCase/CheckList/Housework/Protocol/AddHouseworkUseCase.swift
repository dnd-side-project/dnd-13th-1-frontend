//
//  AddHouseworkUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation

public protocol AddHouseworkUseCase: Sendable {
    func execute(groupId: Int, housework: Housework) async throws
}
