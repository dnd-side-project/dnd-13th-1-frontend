//
//  TagItem.swift
//  AlloDomain
//
//  Created by Assistant on 8/27/25.
//

import Foundation

public struct TagItem: Identifiable, Hashable, Sendable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


