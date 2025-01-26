//
//  GetNovelTextsDataRequest.swift
//  SwiftLearningNovelApp
//
//  Created by 寺田栞理 on 2025/01/25.
//

import APIKit
import Foundation

struct GetNovelTextsDataRequest: APIKit.Request {
    typealias Response = [NovelTextData]
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/novelTexts"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [NovelTextData] {
        print("Received response: \(object)")
        // ステータスコードの確認
        guard (200...299).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        
        // サーバーから受け取ったデータが配列の場合の処理
        if let jsonArray = object as? [[String: Any]] {
            do {
                // JSONDecoderを使って直接デコードするため、一旦Dataに変換
                let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode([NovelTextData].self, from: data)
            } catch {
                throw ResponseError.unexpectedObject(error)
            }
        }
        
        // 想定外のオブジェクトが来た場合
        throw ResponseError.unexpectedObject(object)
    }
}
