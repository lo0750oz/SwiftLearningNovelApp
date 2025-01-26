//
//  PostNewNovelTextRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/25.
//

import APIKit
import Foundation

struct PostNewNovelTextRequest: APIKit.Request {
    typealias Response = Bool
    
    let textDada: NovelTextData
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/novelTexts"
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "id": textDada.id,
            "textNo": textDada.textNo,
            "text": textDada.text,
            "auther": textDada.auther
        ])
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard urlResponse.statusCode == 201 else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return true
    }
}
