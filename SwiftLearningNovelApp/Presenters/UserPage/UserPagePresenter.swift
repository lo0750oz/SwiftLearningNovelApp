//
//  UserPagePresenter.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2024/12/31.
//

import Combine
import Foundation

protocol UserPagePresenterProtocol {
    func didTapAddNovelButton()
    func didTapToNovelPageButton(novelData: NovelData)
    func didSaveViewNovel(novelData: NovelData)
    func getNovelTexts(novelData: NovelData)
}

class UserPagePresenter: UserPagePresenterProtocol {
    private let router: UserPageRouterProtocol
    private let interactor: UserPageInteractorProtocol
    private var appState: AppState
    private var cancellables: Set<AnyCancellable> = []
    
    init(router: UserPageRouterProtocol, appState: AppState, interactor: UserPageInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        self.appState = appState
    }
    
    func didTapAddNovelButton() {
        router.navigateToMakeNewNovelView(appState: appState)
    }
    
    func didTapToNovelPageButton(novelData: NovelData){
        self.didSaveViewNovel(novelData: novelData)
        self.getNovelTexts(novelData: novelData)
        router.navigateToNovelPageView(appState: appState)
    }
    
    func didSaveViewNovel(novelData: NovelData) {
        interactor.saveViewNovel(novel: novelData)
    }
    
    func getNovelTexts(novelData: NovelData) {
        interactor.getNovelTexts(novel: novelData)
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("処理完了")
                    case .failure(let error):
                        print("エラー発生: \(error.localizedDescription)")
                    }
                }, receiveValue: { novelTexts in
                    print("取得したデータ: \(novelTexts)")
                    self.appState.noveltexts = novelTexts
                })
                .store(in: &cancellables)
    }
}
