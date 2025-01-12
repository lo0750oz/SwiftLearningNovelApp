//
//  UserDafaultsManager.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/11.
//

import Foundation
import Combine


class UserDefaultsManager {
    
    private let userKey = "storedUser"
    
    // ユーザー情報を保存
    func saveUser(_ user: UserData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            if let encodedString = String(data: encoded, encoding: .utf8) {
                print("エンコード確認：\(encodedString)")
                UserDefaults.standard.set(encodedString, forKey: userKey)
            }
        }
    }
    
    // ユーザー情報を取得
    func getUser() -> UserData? {
        if let savedUser = UserDefaults.standard.object(forKey: userKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserData.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
    
    // ユーザー情報を削除
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
