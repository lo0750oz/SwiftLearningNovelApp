//
//  UserRegisterRouter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/28.
//

import Foundation
import SwiftUI

protocol UserRegisterRouterProtocol {
    func navigateToHomeView(appState: AppState)
    func navigateToUserPageView(appState: AppState)
}

struct UserRegisterRouter: UserRegisterRouterProtocol {
    func navigateToHomeView(appState: AppState) {
        print("Router: ホーム画面に遷移")
        let homePresenter = HomePresenter(router: HomeRouter(), appState: appState)
        let homeView = HomeView(presenter: homePresenter).environmentObject(appState)
        appState.currentView = AnyView(homeView) // currentViewを更新    }
    }
    
    func navigateToUserPageView(appState: AppState) {
        print("Router: ユーザー画面に遷移")
        let userPagePresenter = UserPagePresenter(router: UserPageRouter(), appState: appState)
        let userPageView = UserPageView(presenter: userPagePresenter).environmentObject(appState)
        appState.currentView = AnyView(userPageView) // currentViewを更新
    }
}
