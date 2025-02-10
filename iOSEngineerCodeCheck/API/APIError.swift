//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

/// API通信時のエラー
enum APIError: Error {
    case invalidQuery
    case invalidUrl
    case httpStatus(code: Int)
    case decode
    case other(message: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidQuery:
            return "クエリが無効です"
        case .invalidUrl:
            return "URLが無効です"
        case .httpStatus(let code):
            return "Httpレスポンスエラー code: \(code)"
        case .decode:
            return "データのデコードに失敗しました"
        case .other(let message):
            return message
        }
    }
}
