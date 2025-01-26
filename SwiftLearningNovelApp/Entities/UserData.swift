//
//  UserData.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/03.
//

import Foundation

struct UserData: Codable, Identifiable, Equatable{
    let id: String
    let password: String
    let mail: String?
    var novelSpace: String?
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.id == rhs.id &&
        lhs.password == rhs.password &&
        lhs.mail == rhs.mail &&
        lhs.novelSpace == rhs.novelSpace
    }
}
