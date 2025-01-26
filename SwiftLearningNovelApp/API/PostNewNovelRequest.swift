//
//  PostNewNovelRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/13.
//

import APIKit
import Foundation

struct PostNewNovelRequest: APIKit.Request {
    typealias Response = Bool
    
    let novelData: NovelData
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/novelList"
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "id": novelData.id,
            "title": novelData.title,
            "memberOne": novelData.memberOne,
            "memberTwo": novelData.memberTwo
        ])
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard urlResponse.statusCode == 201 else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return true
    }
}
