//
//  UserPagePresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/31.
//

import Foundation

protocol UserPagePresenterProtocol {
    func didTapAddNovelButton()
}

struct UserPagePresenter: UserPagePresenterProtocol {
    private let router: UserPageRouterProtocol
    private var appState: AppState
    
    init(router: UserPageRouterProtocol, appState: AppState) {
        self.router = router
        self.appState = appState
    }
    
    func didTapAddNovelButton() {
        router.navigateToMakeNewNovelView(appState: appState)
    }
}
