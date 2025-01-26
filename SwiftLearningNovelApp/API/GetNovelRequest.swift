//
//  GetNovelListRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/12.
//

import APIKit
import Foundation

struct GetNovelRequest: APIKit.Request {
    typealias Response = NovelData
    
    let id: String
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/novelList/\(id)"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> NovelData {
        print("Received response: \(object)")
        guard let jsonObject = object as? [String: Any],
              let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) else {
            throw ResponseError.unexpectedObject(object)
        }
        
        do {
            let novelData = try JSONDecoder().decode(NovelData.self, from: data)
            return novelData
        } catch {
            print("Decoding error: \(error)")
            throw ResponseError.unexpectedObject(object)
        }
    }
}
