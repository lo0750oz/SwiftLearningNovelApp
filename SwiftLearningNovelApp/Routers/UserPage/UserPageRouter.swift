//
//  UserPageRouter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/31.
//

import Foundation
import SwiftUI

protocol UserPageRouterProtocol {
    func navigateToMakeNewNovelView(appState: AppState)
}

struct UserPageRouter: UserPageRouterProtocol {
    func navigateToMakeNewNovelView (appState: AppState) {
        print("Router: 小説新規作成に遷移")
//        let makeNewNovelView = MakeNewNovelView().environmentObject(appState)
//        appState.currentView = AnyView(makeNewNovelView)
        appState.navigationPath.append("MakeNewNovelView")
    }
}
