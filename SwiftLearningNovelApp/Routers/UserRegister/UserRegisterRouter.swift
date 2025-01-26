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
    let apiClient = APIClient()
    
    func navigateToHomeView(appState: AppState) {
        print("Router: ホーム画面に遷移")
        let homePresenter = HomePresenter(router: HomeRouter(), appState: appState)
        let homeView = HomeView(presenter: homePresenter).environmentObject(appState)
        appState.currentView = AnyView(homeView) // currentViewを更新    }
    }
    
    func navigateToUserPageView(appState: AppState) {
        print("Router: ユーザー画面に遷移")
        let userPagePresenter = UserPagePresenter(router: UserPageRouter(), appState: appState, interactor: UserPageInteractor(appState: appState, apiClient: apiClient))
        let router = MakeNewNovelRouter()
        let loginInteractor = LoginInteractor(apiClient: apiClient, appState: appState)
        let interactor = MakeNewNovelInteractor(apiClient: apiClient, appState: appState, loginInteractor: loginInteractor)
        let makeNewNovelPresenter = MakeNewNovelPresenter(interactor: interactor, loginInteractor: loginInteractor, router: router, appState: appState)
        let AddNewNovelTextRouter = AddNewNovelTextRouter()
        let AddNewNovelTextInteractor = AddNewNovelTextInteractor(apiClient: apiClient, appState: appState)
        let AddNewNovelTextPresenter = AddNewNovelTextPresenter(interactor: AddNewNovelTextInteractor, router: AddNewNovelTextRouter, appState: appState)
        let userPageView = UserPageView(presenter: userPagePresenter, makeNewNovelPresenter: makeNewNovelPresenter, AddNewNovelTextPresenter: AddNewNovelTextPresenter).environmentObject(appState)
        appState.currentView = AnyView(userPageView) // currentViewを更新
    }
}
