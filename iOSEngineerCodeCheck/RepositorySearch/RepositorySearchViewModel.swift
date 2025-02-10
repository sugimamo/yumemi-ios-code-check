//
//  RepositorySearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/09.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine
import UIKit

class RepositorySearchViewModel: ObservableObject {
    
    /// リポジトリ情報
    @Published var repositories: [Repository] = []
    /// 検索処理のタスク
    private var searchTask: Task<Void, Never>?
    /// 選択したリポジトリのインデックス
    var selectedIndex: Int?
    /// API通信用
    private let apiClient = RepositorySearchAPI()
    
    let searchedNotice: PassthroughSubject<Void, Never> = .init()
    
    /// 画面遷移のSegueIdentifier
    enum SegueIdentifier {
        /// リポジトリ詳細画面への遷移
        static let repositoryDetail = "RepositoryDetail"
    }
    
    /// 画面遷移時処理
    /// - Parameter segue: StoryboradのSegue
    func prepareScreenTransition(for segue: UIStoryboardSegue) {
        if segue.identifier == SegueIdentifier.repositoryDetail, let dtl = segue.destination as? RepositoryDetailViewController {
            dtl.viewModel = RepositoryDetailViewModel(repository: self.repositories[selectedIndex ?? 0])
        }
    }
    
    /// 選択したインデックスを設定する
    /// - Parameter index: インデックス
    func setSelectedIndex(to index: Int) {
        selectedIndex = index
    }
    
    /// 検索中のタスクをキャンセルする
    func cancelSearchTask() {
        searchTask?.cancel()
    }
    
    /// リポジトリを検索する
    /// - Parameter searchWord: 検索ワード
    func searchRepository(with searchWord: String?) {
        searchTask = Task {
            do {
                let searchRepository = try await apiClient.execute(query: searchWord)
                repositories = searchRepository.items
            } catch {
                print(error.localizedDescription)
            }
            searchedNotice.send()
        }
    }
    /// 検索バーのテキストが変更されたときの処理
    func searchBarTextDidChange(_ searchText: String) {
        cancelSearchTask()
        if searchText.isEmpty {
            // 検索ワードが空の場合はリポジトリをクリアする
            repositories.removeAll()
        }
    }
}
