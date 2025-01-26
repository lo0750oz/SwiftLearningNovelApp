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
        if let savedUserString = UserDefaults.standard.string(forKey: userKey), // String型で取得
           let savedUserData = savedUserString.data(using: .utf8) { // StringをDataに変換
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserData.self, from: savedUserData) { // DataをUserDataにデコード
                return loadedUser
            }
        }
        return nil
    }
    
    // ユーザー情報を更新
    func updateUser(updateBlock: (inout UserData) -> Void) {
        if var user = getUser() {
            updateBlock(&user) // 引数のクロージャを使ってプロパティを更新
            saveUser(user)     // 更新後のユーザー情報を保存
        } else {
            print("ユーザー情報が存在しません")
        }
    }
    
    // ユーザー情報を削除
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
