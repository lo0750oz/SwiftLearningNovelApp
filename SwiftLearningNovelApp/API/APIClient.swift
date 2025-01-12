//
//  APIService.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/05.
//

import Foundation
import Combine
import APIKit

protocol APIClientProtocol {
    func send<T: APIKit.Request>(_ request: T) -> AnyPublisher<T.Response, Error>
}

class APIClient: APIClientProtocol {
    func send<T: APIKit.Request>(_ request: T) -> AnyPublisher<T.Response, Error> {
        let subject = PassthroughSubject<T.Response, Error>()
        
        Session.send(request) { result in
            switch result {
            case .success(let response):
                subject.send(response)
                subject.send(completion: .finished)
            case .failure(let error):
                print("API request failed with error: \(error.localizedDescription)")
                if let apiError = error as? SessionTaskError {
                    print("SessionTaskError details: \(apiError)")
                }
                subject.send(completion: .failure(error))
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
}
