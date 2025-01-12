//
//  PostNewUserDataRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/05.
//

import APIKit
import Foundation

struct PostNewUserDataRequest: APIKit.Request {
    typealias Response = Bool
    
    let userData: UserData
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/userList"
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "id": userData.id,
            "password": userData.password,
            "mail": userData.mail ?? "",
            "novelSpace": userData.novelSpace ?? ""
        ])
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard urlResponse.statusCode == 201 else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return true
    }
}
