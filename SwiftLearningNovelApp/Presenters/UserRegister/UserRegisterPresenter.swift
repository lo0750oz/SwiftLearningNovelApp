//
//  UserRegisterPresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/28.
//

import Foundation
import Combine

protocol UserRegisterPresenterProtocol {
    func didTapRegisterButton(password: String, mail: String)
    func didTapPageBackButton()
    func didTaptoUserPageButton()
}

class UserRegisterPresenter: UserRegisterPresenterProtocol {
    
    private let router: UserRegisterRouterProtocol
    private var appState: AppState
    private let interactor: UserRegisterInteractorProtocol
    private var cancellables: Set<AnyCancellable> = []
        
    init(router: UserRegisterRouterProtocol, appState: AppState, interactor: UserRegisterInteractorProtocol){
        self.router = router
        self.appState = appState
        self.interactor = interactor
    }
    
    func didTapRegisterButton(password: String, mail: String) {
        interactor.userRegister(password: password, mail: mail)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("登録失敗: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    print("登録成功")
                    // 成功時の処理（例えば、次の画面へ遷移など）
                } else {
                    print("登録失敗")
                    // 失敗時の処理
                }
            })
            .store(in: &cancellables)
        
    }
    
    func didTapPageBackButton() {
        router.navigateToHomeView(appState: appState)
    }
    
    func didTaptoUserPageButton() {
        router.navigateToUserPageView(appState: appState)
    }
}
