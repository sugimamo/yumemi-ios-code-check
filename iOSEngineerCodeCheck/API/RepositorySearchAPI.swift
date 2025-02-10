//
//  RepositorySearchAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

/// リポジトリ検索API実行用クラス
class RepositorySearchAPI {
    
    private static let url: String = "https://api.github.com/search/repositories?q=%@"
    
    /// 通信実施
    /// - Parameter query: クエリ
    /// - Returns: 検索結果
    func execute(query: String?) async throws -> SearchRepository {
        guard let query = query, !query.isEmpty else {
            throw APIError.invalidQuery
        }
        let searchUrlString = String(format: RepositorySearchAPI.url, query)
        guard let searchUrl = URL(string: searchUrlString) else {
            throw APIError.invalidUrl
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: searchUrl)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.other(message: "Empty HttpResponse")
            }
            guard httpResponse.statusCode == 200 else {
                throw APIError.httpStatus(code: httpResponse.statusCode)
            }
            return try decodeToSearchRepository(from: data)
        } catch {
            throw APIError.other(message: error.localizedDescription)
        }
    }
    
    /// レスポンスデータをSearchRepository型にデコードする
    /// - Parameter data: レスポンスデータ
    /// - Returns: リポジトリ情報
    func decodeToSearchRepository(from data: Data) throws -> SearchRepository {
        do {
            return try JSONDecoder().decode(SearchRepository.self, from: data)
        } catch {
            throw APIError.decode
        }
    }
}
