//
//  AppState.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/04.
//

import Combine
import SwiftUI

final class AppState: ObservableObject {
    @Published var isLogin: Bool = UserDefaults.standard.bool(forKey: "login") {
        didSet {
            if !isLogin {
                // ログアウト時にホーム画面に遷移
                let router = HomeRouter()
                let presenter = HomePresenter(router: router, appState: self)
                currentView = AnyView(
                    HomeView(presenter: presenter)
                        .environmentObject(self)
                )
            }
            // ユーザーデフォルトに値を保存
            UserDefaults.standard.set(isLogin, forKey: "login")
        }
    }
    
    @Published var currentView: AnyView? = nil
    @Published var navigationPath: NavigationPath = NavigationPath()
    @Published var user: UserData? = nil
    @Published var novelData: [NovelData] = {
        if let data = UserDefaults.standard.data(forKey: "novelList") {
            let decoder = JSONDecoder()
            return (try? decoder.decode([NovelData].self, from: data)) ?? []
        }
        return []
    }() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(novelData) {
                UserDefaults.standard.set(encoded, forKey: "novelList")
            }
        }
    }
    
    func removeNovelData() {
        UserDefaults.standard.removeObject(forKey: "novelList")
        self.novelData = []
    }
    
    @Published var viewNovelData: NovelData? = {
        if let data = UserDefaults.standard.data(forKey: "viewNovel") {
            let decoder = JSONDecoder()
            return try? decoder.decode(NovelData.self, from: data)
        }
        return nil
    }() {
        didSet {
            if let novelData = viewNovelData {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(novelData) {
                    UserDefaults.standard.set(encoded, forKey: "viewNovel")
                }
            }
        }
    }
    
    func removeViewNovelData(){
        UserDefaults.standard.removeObject(forKey: "viewNovel")
    }
    
    @Published var noveltexts: [String] = {
        if let data = UserDefaults.standard.data(forKey: "novelList") {
            let decoder = JSONDecoder()
            return (try? decoder.decode([String].self, from: data)) ?? []
        }
        return []
    }() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(noveltexts) {
                UserDefaults.standard.set(encoded, forKey: "novelTexts")
            }
        }
    }
}

