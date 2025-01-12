//
//  getUserDataRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/03.
//

import APIKit
import Foundation

struct GetUserDataRequest: APIKit.Request {
    typealias Response = UserData
    
    let id: String
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/userList/\(id)"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> UserData {
        print("Received response: \(object)")
        // もし object が Data 型でなければ、JSONSerialization を使って Data に変換
        guard let jsonObject = object as? [String: Any],
              let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) else {
            throw ResponseError.unexpectedObject(object)
        }
        
        // JSONDecoder でデコード
        do {
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            return userData
        } catch {
            print("Decoding error: \(error)")
            throw ResponseError.unexpectedObject(object)
        }
    }
}
