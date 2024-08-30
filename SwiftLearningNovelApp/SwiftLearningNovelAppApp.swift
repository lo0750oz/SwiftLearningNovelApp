//
//  SwiftLearningNovelAppApp.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/08/30.
//

import SwiftUI

@main
struct SwiftLearningNovelAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
