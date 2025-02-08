//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

/// リポジトリ検索画面のViewController
class RepositorySearchViewController: UITableViewController {
    
    /// リポジトリ検索バー
    @IBOutlet weak var repositorySearchBar: UISearchBar!
    
    /// リポジトリ情報
    var repositories: [Repository] = []
    /// 検索処理のタスク
    private var searchTask: URLSessionTask?
    /// 選択したリポジトリのインデックス
    var selectedIndex: Int?
    /// 検索するURL
    private static let searchUrl: String = "https://api.github.com/search/repositories?q=%@"
    
    /// 画面遷移のSegueIdentifier
    enum SegueIdentifier {
        /// リポジトリ詳細画面への遷移
        static let repositoryDetail = "RepositoryDetail"
    }
    
    override func viewDidLoad() {
        // 画面読み込み時の処理
        super.viewDidLoad()
        repositorySearchBar.placeholder = "GitHubのリポジトリを検索できます"
        repositorySearchBar.text = ""
        repositorySearchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 画面遷移時の処理
        if segue.identifier == SegueIdentifier.repositoryDetail, let dtl = segue.destination as? RepositoryDetailViewController {
            dtl.repositorySearchVC = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの表示
        let cell = UITableViewCell()
        let rp = repositories[indexPath.row]
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルタップ時に呼ばれる
        selectedIndex = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.repositoryDetail, sender: self)
    }
    
    /// レスポンスデータをSearchRepository型にデコードする
    /// - Parameter data: レスポンスデータ
    /// - Returns: リポジトリ情報
    func decodeToSearchRepository(from data: Data) -> SearchRepository? {
        var searchRepository: SearchRepository? = nil
        do {
            searchRepository =  try JSONDecoder().decode(SearchRepository.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return searchRepository
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 検索バーがタップされた時に呼ばれる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 検索バーの文字列が変更された時に呼ばれる
        searchTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索ボタンが押された時に呼ばれる
        if let searchWord = searchBar.text, !searchWord.isEmpty {
            let searchUrlString = String(format: RepositorySearchViewController.searchUrl, searchWord)
            guard let searchUrl = URL(string: searchUrlString) else { return }
            searchTask = URLSession.shared.dataTask(with: searchUrl) { [weak self] (data, res, err) in
                guard let self = self else { return }
                guard let data = data else { return }
                guard let searchRepository = self.decodeToSearchRepository(from: data) else { return }
                self.repositories = searchRepository.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            // 検索実施
            searchTask?.resume()
        }
    }
}
