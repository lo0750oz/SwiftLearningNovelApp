//
//  AppState.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/09/04.
//

import Combine
import SwiftUI

final class AppState: ObservableObject {
    @Published var isLogin = false
    @Published var currentView: AnyView? = nil
}
