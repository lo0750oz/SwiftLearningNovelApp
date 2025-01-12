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
    // APIClientのインスタンスを作成（必要に応じて依存性注入）
    let apiClient = APIClient()
    
    func navigateToLoginView(appState: AppState) {
        print("Router: ログイン画面に遷移")
        // LoginInteractorを作成
        let loginInteractor = LoginInteractor(apiClient: apiClient)
        // 遷移先にappStateを渡してログイン画面へ遷移
        let loginPresenter = LoginPresenter(router: LoginRouter(), appState: appState, loginInteractor: loginInteractor)
        let loginView = LoginView(presenter: loginPresenter).environmentObject(appState)
        appState.currentView = AnyView(loginView) // currentViewを更新
    }
    
    func navigateToUserRegisterView(appState: AppState) {
        print("Router: ユーザー登録画面に遷移")
        let userRegisterInterctor = UserRegisterInteractor(apiClient: apiClient, appState: appState)
        // 遷移先にappStateを渡してユーザー登録画面へ遷移
        let userRegisterPresenter = UserRegisterPresenter(router: UserRegisterRouter(), appState: appState, interactor: userRegisterInterctor)
        let userRegisterView = UserRegisterView(presenter: userRegisterPresenter).environmentObject(appState)
        appState.currentView = AnyView(userRegisterView) // currentViewを更新
    }
    
    func navigateToUserPageView(appState: AppState) {
        print("Router: マイページに遷移")
        // 遷移先にappStateを渡してマイページへ遷移
        let userPagePresenter = UserPagePresenter(router: UserPageRouter(), appState: appState)
        let userPageView = UserPageView(presenter: userPagePresenter).environmentObject(appState)
        appState.currentView = AnyView(userPageView) // currentViewを更新
    }
}
