//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

/// リポジトリ詳細画面のViewController
class RepositoryDetailViewController: UIViewController {
    
    /// リポジトリのアバター画像表示用ImageView
    @IBOutlet weak var avatarImageView: UIImageView!
    /// リポジトリ名表示用Label
    @IBOutlet weak var repositoryNameLable: UILabel!
    /// リポジトリの言語表示用Label
    @IBOutlet weak var languageLabel: UILabel!
    /// スターの数表示用Label
    @IBOutlet weak var starsCountLabel: UILabel!
    /// ウォッチャーの数表示用Label
    @IBOutlet weak var watchersCountLabel: UILabel!
    /// フォークの数表示用
    @IBOutlet weak var forksCountLabel: UILabel!
    /// オープンイシューの数表示用
    @IBOutlet weak var openIssueCountLabel: UILabel!
    /// リポジトリ検索画面のViewController
    var repositorySearchVC: RepositorySearchViewController!
        
    override func viewDidLoad() {
        // 画面読み込み時の処理
        super.viewDidLoad()
        let repo = repositorySearchVC.repositories[repositorySearchVC.selectedIndex]
        
        languageLabel.text = "Written in \(repo.language ?? "Unknown")"
        starsCountLabel.text = "\(repo.stargazersCount) stars"
        watchersCountLabel.text = "\(repo.watchersCount) watchers"
        forksCountLabel.text = "\(repo.forksCount) forks"
        openIssueCountLabel.text = "\(repo.openIssuesCount) open issues"
        repositoryNameLable.text = repo.fullName
        Task { @MainActor in
            self.avatarImageView.image = await getAvatorImage(for: repo.owner.avatarUrl)
        }
    }
    
    /// リポジトリのアバター画像を取得する
    func getAvatorImage(for url: URL) async -> UIImage?{
        var image: UIImage? = nil
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
}
