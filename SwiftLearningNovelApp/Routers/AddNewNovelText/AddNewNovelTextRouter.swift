//
//  AddNewNovelTextRouter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/26.
//

import Foundation

protocol AddNewNovelTextRouterProtocol {
    func navigateToNovelPageView(appState: AppState)
}

struct AddNewNovelTextRouter: AddNewNovelTextRouterProtocol {
    func navigateToNovelPageView(appState: AppState) {
        print("Router: 小説ページに遷移")
        appState.navigationPath.append("NovelPageView")
    }
}
