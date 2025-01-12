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
}
