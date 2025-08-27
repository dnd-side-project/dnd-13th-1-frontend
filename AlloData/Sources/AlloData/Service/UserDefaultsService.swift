//
//  UserDefaultsService.swift
//  AlloData
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation

struct UserDefaultsService: Sendable {
    static var isSignedIn: Bool {
        get { UserDefaults.standard.bool(forKey: "isSignedIn") }
        set { UserDefaults.standard.set(newValue, forKey: "isSignedIn") }
    }
    
    static var groupId: Int? {
        get { UserDefaults.standard.integer(forKey: "groupId") }
        set { UserDefaults.standard.set(newValue, forKey: "groupId") }
    }
}
