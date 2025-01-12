//
//  UserRegisterInteractor.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/11.
//

import Combine
import Foundation

protocol UserRegisterInteractorProtocol {
    func userRegister(password: String, mail: String) -> AnyPublisher<Bool, Error>
}

class UserRegisterInteractor: UserRegisterInteractorProtocol {
    private let apiClient: APIClientProtocol
    private let userDefaultsManager = UserDefaultsManager()
    private var appState: AppState
    
    init(apiClient: APIClientProtocol, appState: AppState) {
        self.apiClient = apiClient
        self.appState = appState
    }
    
    func userRegister(password: String, mail: String) -> AnyPublisher<Bool, any Error> {
        //        ユーザーID採番
        let uuid = UUID().uuidString
        let shortUUID = String(uuid.prefix(10))
        
        //        送信データ作成
        let userData = UserData(
            id: shortUUID,
            password: password,
            mail: mail,
            novelSpace: nil)
        
        //        データ送信
        let request = PostNewUserDataRequest(userData: userData)
        print("リクエスト：\(request)")
        return apiClient.send(request)
            .map { _ in
                // ユーザー登録成功時にUserDefaultsに保存
                let user = UserData(id: shortUUID, password: password, mail: mail, novelSpace: nil)
                self.userDefaultsManager.saveUser(user)
                self.appState.isLogin = true
                print("ユーザーデータ：\(user)")
                return true }
            .catch { _ in Just(false).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
        
    }
}
