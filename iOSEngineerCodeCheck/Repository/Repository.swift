//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/08.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

/// リポジトリの検索結果のレスポンス
struct SearchRepository: Codable {
    let items: [Repository]
}

/// リポジトリ情報
struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: RepositoryOwner
    let language: String?
    let repositoryURL: URL
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case language = "language"
        case repositoryURL = "html_url"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner = "owner"
    }
}

/// リポジトリの所有者情報
struct RepositoryOwner: Codable {
    let id: Int
    let name: String
    let avatarUrl: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}
