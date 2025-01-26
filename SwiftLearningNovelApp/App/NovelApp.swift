//
//  NovelApp.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/01.
//

import SwiftUI
import APIKit

@main
struct SwiftLearningNovelAppApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if let currentView = appState.currentView {
                currentView // currentViewがnilでない場合に表示
            } else {
                // 初期表示はHomeView
                let router = HomeRouter()
                let presenter = HomePresenter(router: router, appState: appState)
                HomeView(presenter: presenter)
                    .environmentObject(appState)
            }
        }
    }
}
