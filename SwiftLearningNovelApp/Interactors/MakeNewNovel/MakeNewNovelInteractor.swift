//
//  MakeNewNovelInteractor.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import Combine
import Foundation

protocol MakeNewNovelInteractorProtocol {
    func addNewNovel(title: String,id: String) -> AnyPublisher<Bool, Error>
    func updateNovelSpace(id: String, novelId: String) -> AnyPublisher<Bool, Error>
}

class MakeNewNovelInteractor: MakeNewNovelInteractorProtocol {
    private let apiClient: APIClientProtocol
    private var appState: AppState
    private let userDefaultsManager = UserDefaultsManager()
    private let loginInteractor: LoginInteractorProtocol
    
    init(apiClient: APIClientProtocol, appState: AppState, loginInteractor: LoginInteractorProtocol) {
        self.apiClient = apiClient
        self.appState = appState
        self.loginInteractor = loginInteractor
    }
    
    func addNewNovel(title: String,id: String) -> AnyPublisher<Bool, Error>{
        let novelId = UUID().uuidString
        let user = userDefaultsManager.getUser()?.id ?? "Unknown"
        
        let novelData = NovelData(
            id: novelId,
            title: title,
            memberOne: user,
            memberTwo: id)
        
        let request = PostNewNovelRequest(novelData: novelData)
        print("リクエスト：\(request)")
        return apiClient.send(request)
            .flatMap { success -> AnyPublisher<Bool, Error> in
                if success {
                    // 1回目のupdateNovelSpace呼び出し
                    return self.updateNovelSpace(id: user, novelId: novelId)
                        .flatMap { _ in
                            // 2回目のupdateNovelSpace呼び出し
                            self.updateNovelSpace(id: id, novelId: novelId)
                        }
                        .handleEvents(receiveCompletion: { completion in
                            // 最後にnovelSpaceを更新
                            if case .finished = completion {
                                print("追加前確認：\(self.userDefaultsManager.getUser())")
                                self.userDefaultsManager.updateUser { user in
                                    if let currentNovelSpace = user.novelSpace {
                                        user.novelSpace = currentNovelSpace + ",\(novelId)"
                                    } else {
                                        user.novelSpace = novelId
                                    }
                                }
                                
                                // 更新後、最新データを取得
                                if let updatedUser = self.userDefaultsManager.getUser() {
                                    self.appState.user = updatedUser
                                }
                                print("追加確認：\(self.userDefaultsManager.getUser())")
                            }
                        })
                        .eraseToAnyPublisher()
                } else {
                    return Just(false)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .catch { error in
                Just(false)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func updateNovelSpace(id: String, novelId: String) -> AnyPublisher<Bool, Error>{
        let request = GetUserDataRequest(id: id)
        print("リクエスト：\(request)")
        
        return apiClient.send(request)
            .flatMap { userData -> AnyPublisher<Bool, Error> in
                let currentNovelSpace = userData.novelSpace ?? ""
                
                if currentNovelSpace.isEmpty {
                    // novelSpaceが空文字列の場合、新しいnovelIdを設定
                    let patchRequest = PatchNovelSpaceRequest(id: id, novelSpace: novelId)
                    print("Patchリクエスト（空の場合）：\(patchRequest)")
                    
                    return self.apiClient.send(patchRequest)
                        .map { _ in true }
                        .eraseToAnyPublisher()
                } else {
                    // novelSpaceが既に存在する場合、新しいnovelIdを追加
                    let updatedNovelSpace = currentNovelSpace + "," + novelId
                    let patchRequest = PatchNovelSpaceRequest(id: id, novelSpace: updatedNovelSpace)
                    print("Patchリクエスト（既存の場合）：\(patchRequest)")
                    
                    return self.apiClient.send(patchRequest)
                        .map { _ in true }
                        .eraseToAnyPublisher()
                }
            }
            .catch { error in
                Just(false)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
