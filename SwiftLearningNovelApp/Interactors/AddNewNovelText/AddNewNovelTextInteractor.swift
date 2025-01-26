//
//  AddNewNovelTextInteractor.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/25.
//

import Combine
import Foundation

protocol AddNewNovelTextInteractorProtocol {
    func addNewText(text: String, completion: @escaping (Bool) -> Void)
}

class AddNewNovelTextInteractor: AddNewNovelTextInteractorProtocol {
    private let apiClient: APIClientProtocol
    private let appState: AppState
    private let userDefaultsManager = UserDefaultsManager()
    private var cancellables: Set<AnyCancellable> = []
    
    init(apiClient: APIClientProtocol, appState: AppState) {
        self.apiClient = apiClient
        self.appState = appState
    }
    
    func addNewText(text: String, completion: @escaping (Bool) -> Void) {
        let novelId = appState.viewNovelData?.id ?? "Unknown"
        let textNo = appState.noveltexts.count + 1
        let auther = userDefaultsManager.getUser()?.id ?? "Unknown"
        
        let textData = NovelTextData(
            id: novelId,
            textNo: textNo,
            text: text,
            auther: auther
        )
        
        let request = PostNewNovelTextRequest(textDada: textData)
        print("リクエスト：\(request)")
        
        // Combineを使用して非同期APIリクエストを送信
        apiClient.send(request)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    print("APIリクエスト失敗: \(error)")
                    completion(false) // エラーが発生した場合
                }
            }, receiveValue: { isSuccess in
                print("APIリクエスト成功！受信した値: \(isSuccess)")
                if isSuccess {
                    print("UserDefaultsを更新")
                    self.appState.noveltexts.append(text)
                    completion(true) // 成功した場合
                } else {
                    completion(false) // 失敗した場合
                }
            })
            .store(in: &cancellables) // Cancellableを保存
    }
}
