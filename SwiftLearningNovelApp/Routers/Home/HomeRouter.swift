//
//  HomeRouter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/16.
//

import SwiftUI

protocol HomeRouterProtocol {
    func navigateToLoginView(appState: AppState)
    func navigateToUserRegisterView(appState: AppState)
    func navigateToUserPageView(appState: AppState)
}

struct HomeRouter: HomeRouterProtocol {
    func navigateToLoginView(appState: AppState) {
        print("Router: ログイン画面に遷移")
        // 遷移先にappStateを渡してログイン画面へ遷移
        let loginView = LoginView().environmentObject(appState)
        appState.currentView = AnyView(loginView) // currentViewを更新
    }
    
    func navigateToUserRegisterView(appState: AppState) {
        print("Router: ユーザー登録画面に遷移")
        // 遷移先にappStateを渡してユーザー登録画面へ遷移
        let loginView = UserRegisterView().environmentObject(appState)
        appState.currentView = AnyView(loginView) // currentViewを更新
    }
    
    func navigateToUserPageView(appState: AppState) {
        print("Router: マイページに遷移")
        // 遷移先にappStateを渡してマイページへ遷移
        let loginView = UserPageView().environmentObject(appState)
        appState.currentView = AnyView(loginView) // currentViewを更新
    }
}
