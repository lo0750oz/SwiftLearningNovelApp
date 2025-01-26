//
//  MakeNewNovelPresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import Foundation
import Combine

protocol MakeNewNovelPresenterProtocol {
    func didTapAddNewNovelButton(title: String,id: String)
    func goToUserPage()
}

class MakeNewNovelPresenter: MakeNewNovelPresenterProtocol {
    private let interactor: MakeNewNovelInteractorProtocol
    private let loginInteractor: LoginInteractorProtocol
    private let router: MakeNewNovelRouterProtocol
    private var appState: AppState
    private var cancellables: Set<AnyCancellable> = []
    
    init(interactor: MakeNewNovelInteractorProtocol,loginInteractor: LoginInteractorProtocol, router: MakeNewNovelRouterProtocol, appState: AppState) {
        self.interactor = interactor
        self.loginInteractor = loginInteractor
        self.router = router
        self.appState = appState
    }
    
    func didTapAddNewNovelButton(title: String,id: String) {
        // バックグラウンドスレッドで非同期処理を行う
        DispatchQueue.global(qos: .userInitiated).async {
            // semaphoreを作成して非同期処理を同期的に待機
            let semaphore = DispatchSemaphore(value: 0)
            
            self.interactor.addNewNovel(title: title, id: id)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("登録成功")
                        semaphore.signal()
                    case .failure(let error):
                        print("登録失敗: \(error.localizedDescription)")
                        semaphore.signal() // エラー後も信号を送信して次の処理を進める
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
                .store(in: &self.cancellables)
            
            // semaphoreが信号を受け取るまで待機
            semaphore.wait()
            
            // 新しい小説が登録された後にユーザー情報を更新
            DispatchQueue.main.async {
                self.goToUserPage()
            }
        }
        
    }
    
    func goToUserPage(){
        let userId: String = appState.user?.id ?? ""
        
        loginInteractor.getNovelList(userId: userId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("小説リスト取得エラー: \(error.localizedDescription)")
                    // エラー処理を追加
                }
            }, receiveValue: { [self] success in
                if success {
                    print("小説リスト取得成功")
                    DispatchQueue.main.async {
                        appState.navigationPath.removeLast()
                    }
                }
            })
            .store(in: &self.cancellables)
        
    }
}
