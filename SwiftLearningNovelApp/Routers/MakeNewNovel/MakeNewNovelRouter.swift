//
//  MakeNewNovelRouter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/14.
//

import Foundation

protocol MakeNewNovelRouterProtocol {
    func navigateToUserPageView(appState: AppState)
}

struct MakeNewNovelRouter: MakeNewNovelRouterProtocol {
    func navigateToUserPageView(appState: AppState) {
        print("Router: マイページに遷移")
        appState.navigationPath.append("UserPageView")
    }
}
