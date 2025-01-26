//
//  UserPageInteractor.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import Combine
import Foundation

protocol UserPageInteractorProtocol {
    func saveViewNovel(novel: NovelData)
    func getNovelTexts(novel: NovelData) -> AnyPublisher<[String], Error>
}

class UserPageInteractor: UserPageInteractorProtocol {
    private let apiClient: APIClientProtocol
    private var appState: AppState
    
    init(appState: AppState, apiClient: APIClientProtocol) {
        self.appState = appState
        self.apiClient = apiClient
    }
    
    func saveViewNovel(novel: NovelData) {
        self.appState.viewNovelData = novel
        print("小説データ：\(self.appState.viewNovelData)")
    }
    
    func getNovelTexts(novel: NovelData) -> AnyPublisher<[String], Error> {
        let request = GetNovelTextsDataRequest()
        let novelId = novel.id
        print("リクエスト：\(request)")
        return apiClient.send(request)
            .map { novelTexts -> [NovelTextData] in
                // フィルタリングして、idがtargetIdと一致するものを抽出
                novelTexts.filter { $0.id == novelId }
            }
            .map { filteredTexts -> [NovelTextData] in
                // textNoで昇順ソート
                filteredTexts.sorted(by: { $0.textNo < $1.textNo })
            }
            .map { sortedTexts -> [String] in
                // textプロパティだけを取り出したString型の配列を作成
                sortedTexts.map { $0.text }
            }
            .eraseToAnyPublisher()
    }
}
