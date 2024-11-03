//
//  HomePresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/16.
//

import Foundation

protocol HomePresenterProtocol {
    func didTapLoginButton()
    func didTapUserRegisterButton()
    func didTapUserPageViewButton()
}

struct HomePresenter: HomePresenterProtocol {
    private let router: HomeRouterProtocol
    private var appState: AppState
    
    init(router: HomeRouterProtocol, appState: AppState) {
        self.router = router
        self.appState = appState
    }
    
    func didTapLoginButton() {
        print("Presenter")
        // Routerを使ってログイン画面に遷移し、appStateも引き継ぐ
        router.navigateToLoginView(appState: appState)
    }
    
    func didTapUserRegisterButton() {
        print("Presenter")
        // Routerを使ってログイン画面に遷移し、appStateも引き継ぐ
        router.navigateToUserRegisterView(appState: appState)
    }
    
    func didTapUserPageViewButton() {
        print("Presenter")
        // Routerを使ってログイン画面に遷移し、appStateも引き継ぐ
        router.navigateToUserPageView(appState: appState)
    }
}
