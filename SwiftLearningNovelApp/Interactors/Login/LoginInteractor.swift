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
}

class LoginInteractor: LoginInteractorProtocol {
    private let apiClient: APIClientProtocol
    private let userDefaultsManager = UserDefaultsManager()
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func login(userId: String, password: String) -> AnyPublisher<Bool, Error> {
        let request = GetUserDataRequest(id: userId)
        print("リクエスト：\(request)")
        return apiClient.send(request)
            .tryMap { userData in
                if userData.password == password {
                    self.userDefaultsManager.saveUser(userData)
                    return true
                } else {
                    throw NSError(domain: "LoginError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid password"])
                }
            }
            .eraseToAnyPublisher()
    }
}
