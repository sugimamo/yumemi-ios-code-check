//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

/// リポジトリ検索画面のViewController
class RepositorySearchViewController: UITableViewController {
    
    /// リポジトリ検索バー
    @IBOutlet weak var repositorySearchBar: UISearchBar!
    /// ViewModel
    var viewModel: RepositorySearchViewModel = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var loadingDialog: LoadingDialog = .init(self)
    
    override func viewDidLoad() {
        // 画面読み込み時の処理
        super.viewDidLoad()
        repositorySearchBar.placeholder = "GitHubのリポジトリを検索できます"
        repositorySearchBar.text = ""
        repositorySearchBar.delegate = self
        viewModel.searchedNotice
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.loadingDialog.dismiss()
                self?.tableView.reloadData()
            }).store(in: &cancellables)
        
        tableView.register(
            UINib(nibName: "RepositoryCell", bundle: nil),
            forCellReuseIdentifier: "RepositoryCell")
        
        setAccesibilityId()
    }
    
    func setAccesibilityId() {
        repositorySearchBar.searchTextField.accessibilityIdentifier = "RepositorySearchView.SearchBar.SearchTextField"
        tableView.accessibilityIdentifier = "RepositorySearchView.SearchTableView"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 画面遷移時の処理
        viewModel.prepareScreenTransition(for: segue)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数
        return viewModel.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さ
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        let rp = viewModel.repositories[indexPath.row]
        cell.setupCell(repository: rp)
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルタップ時に呼ばれる
        viewModel.setSelectedIndex(to: indexPath.row)
        performSegue(withIdentifier: RepositorySearchViewModel.SegueIdentifier.repositoryDetail, sender: self)
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
        viewModel.cancelSearchTask()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索ボタンが押された時に呼ばれる
        // キーボードを閉じる
        searchBar.resignFirstResponder()
        loadingDialog.LoadingMessage(title: "検索中", message: "少々お待ちください") { [weak self] in
            self?.viewModel.cancelSearchTask()
        }
        viewModel.searchRepository(with: searchBar.text)
    }
}
