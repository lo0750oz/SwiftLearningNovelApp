//
//  PatchNovelSpaceRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/15.
//

import APIKit
import Foundation

struct PatchNovelSpaceRequest: APIKit.Request {
    typealias Response = Bool
    
    let id: String
    let novelSpace: String
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .patch
    }
    
    var path: String {
        return "/userList/\(id)"
    }
    
    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "novelSpace": "\(novelSpace)"
        ])
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard urlResponse.statusCode == 200 else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return true
    }
}
