//
//  LoginInteractor.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/05.
//

import Combine
import Foundation

protocol LoginInteractorProtocol {
    func login(userId: String, password: String) -> AnyPublisher<Bool, Error>
    func getNovelList(userId: String) -> AnyPublisher<Bool, Error>
}

class LoginInteractor: LoginInteractorProtocol {
    private let apiClient: APIClientProtocol
    private let userDefaultsManager = UserDefaultsManager()
    private var appState: AppState
    
    init(apiClient: APIClientProtocol, appState: AppState) {
        self.apiClient = apiClient
        self.appState = appState
    }
    
    func login(userId: String, password: String) -> AnyPublisher<Bool, Error> {
        let request = GetUserDataRequest(id: userId)
        print("リクエスト：\(request)")
        return apiClient.send(request)
            .tryMap { userData in
                if userData.password == password {
                    self.userDefaultsManager.saveUser(userData)
                    print("ユーザーデータ：\(self.userDefaultsManager.getUser())")
                    return true
                } else {
                    throw NSError(domain: "LoginError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid password"])
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getNovelList(userId: String) -> AnyPublisher<Bool, Error>
    {
        guard let novelSpaces = self.userDefaultsManager.getUser()?.novelSpace else {
            //            return Fail(error: NSError(domain: "GetNovelListError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No novel space data found"]))
            //                .eraseToAnyPublisher()
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        print("novelSpaces確認：\(novelSpaces)")
        appState.removeNovelData()
        let novelIds = novelSpaces.split(separator: ",").map { String($0) }
        
        let publishers = novelIds.map { novelId in
            let request = GetNovelRequest(id: novelId) // Assuming GetNovelRequest takes a novelId parameter
            print("リクエスト：\(request)")
            return apiClient.send(request)
                .tryMap { novelData in
                    self.appState.novelData.append(novelData)
                    print("保存データ：\(self.appState.novelData)")
                    return true
                }
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(publishers)
                .collect()
                .map { _ in true }
                .eraseToAnyPublisher()
    }
}
