//
//  AddNewNovelTextPresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/25.
//

import Combine
import Foundation

protocol AddNewNovelTextPresenterProtocol {
    func didTapAddButton(text: String)
    func goToNovelPage()
}

struct AddNewNovelTextPresenter: AddNewNovelTextPresenterProtocol {
    private let interactor: AddNewNovelTextInteractorProtocol
    private let router: AddNewNovelTextRouterProtocol
    private var appState: AppState
    
    init(interactor: AddNewNovelTextInteractorProtocol, router: AddNewNovelTextRouterProtocol, appState: AppState) {
        self.interactor = interactor
        self.router = router
        self.appState = appState
    }
    
    func didTapAddButton(text: String) {
        interactor.addNewText(text: text) { isSuccess in
            if isSuccess {
                print("成功しました！")
                goToNovelPage()
            } else {
                print("失敗しました！")
            }
        }
    }
    
    func goToNovelPage() {
        router.navigateToNovelPageView(appState: appState)
    }
}
