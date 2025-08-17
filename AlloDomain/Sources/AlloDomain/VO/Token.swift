//
//  Token.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation

public struct Token: Sendable {
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    let accessToken: String
}
