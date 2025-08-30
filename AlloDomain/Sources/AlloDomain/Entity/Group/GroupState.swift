//
//  GroupState.swift
//  AlloDomain
//
//  Created by Assistant on 8/30/25.
//

import Foundation

public struct GroupState: Sendable {
    public let cleanliness: Int
    public let state: String
    public let message: String
    
    public init(cleanliness: Int, state: String, message: String) {
        self.cleanliness = cleanliness
        self.state = state
        self.message = message
    }
}

