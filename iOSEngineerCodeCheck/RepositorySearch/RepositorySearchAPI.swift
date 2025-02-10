//
//  RepositorySearchAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

/// リポジトリ検索API実行用クラス
class RepositorySearchAPI: APIClient {
    typealias ResponseData = SearchRepository
    
    private static let url: String = "https://api.github.com/search/repositories?q=%@"
    
    /// 通信実施
    /// - Parameter query: クエリ
    /// - Returns: 検索結果
    func execute(query: String?) async throws -> SearchRepository {
        guard let query = query, !query.isEmpty else {
            throw APIError.invalidQuery
        }
        let searchUrlString = String(format: RepositorySearchAPI.url, query)
        return try await load(url: searchUrlString)
    }
    
    func decode(from data: Data) throws -> SearchRepository {
        do {
            return try JSONDecoder().decode(SearchRepository.self, from: data)
        } catch {
            throw APIError.decode
        }
    }
}
