//
//  NovelApp.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/01.
//

import SwiftUI

@main
struct SwiftLearningNovelAppApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(appState)
        }
    }
}
