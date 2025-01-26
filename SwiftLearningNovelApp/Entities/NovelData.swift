//
//  NovelData.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/12.
//

import Foundation

struct NovelData: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let memberOne: String
    let memberTwo: String
    
    // Hashable準拠
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // 一意な識別子をハッシュに追加
    }
    
    // 等価性を判定するための `==` 演算子を実装
    static func == (lhs: NovelData, rhs: NovelData) -> Bool {
        return lhs.id == rhs.id
    }
}
