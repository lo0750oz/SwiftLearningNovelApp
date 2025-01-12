//
//  LoginPresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/11/03.
//

import Foundation
import Combine

protocol LoginPresenterProtocol {
    func didTapLoginButton()
    func didTapPageBackButton()
    func login(userId: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
    private let router: LoginRouterProtocol
    private var appState: AppState
    private let loginInteractor: LoginInteractorProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(router: LoginRouterProtocol, appState: AppState, loginInteractor: LoginInteractorProtocol) {
        self.router = router
        self.appState = appState
        self.loginInteractor = loginInteractor
    }
    
    func didTapLoginButton() {
        router.navigateToUserPageView(appState: appState)
    }
    
    func didTapPageBackButton() {
        router.navigateToHomeView(appState: appState)
    }
    
    func login(userId: String, password: String) {
        loginInteractor.login(userId: userId, password: password)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("ログインエラー: \(error.localizedDescription)")
                        // 必要に応じてエラー表示などの処理を追加
                    }
                }, receiveValue: { success in
                    if success {
                        print("ログイン成功")
                        // ログイン成功時の処理を追加
                        self.appState.isLogin = true
                        self.didTapLoginButton()
                    } else {
                        print("ログイン失敗")
                        // ログイン失敗時の処理を追加
                    }
                })
                .store(in: &cancellables)
        }
}
