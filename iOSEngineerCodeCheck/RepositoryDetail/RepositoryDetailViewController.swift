//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

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
    var viewModel: RepositoryDetailViewModel!
    private var cancellables: Set<AnyCancellable> = []
        
    override func viewDidLoad() {
        // 画面読み込み時の処理
        super.viewDidLoad()
        languageLabel.text = "Written in \(viewModel.repository.language ?? "Unknown")"
        starsCountLabel.text = "\(viewModel.repository.stargazersCount) stars"
        watchersCountLabel.text = "\(viewModel.repository.watchersCount) watchers"
        forksCountLabel.text = "\(viewModel.repository.forksCount) forks"
        openIssueCountLabel.text = "\(viewModel.repository.openIssuesCount) open issues"
        repositoryNameLable.text = viewModel.repository.fullName
        viewModel.avatarImageModel.loadedImageNotice
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.avatarImageView.image = image
            }).store(in: &cancellables)
        setAccessibilityId()
    }
    
    func setAccessibilityId() {
        avatarImageView.accessibilityIdentifier = "RepositoryDetailView.AvatarImageView"
        repositoryNameLable.accessibilityIdentifier = "RepositoryDetailView.RepositoryNameLabel"
        languageLabel.accessibilityIdentifier = "RepositoryDetailView.LanguageLabel"
        starsCountLabel.accessibilityIdentifier = "RepositoryDetailView.StarLabel"
        watchersCountLabel.accessibilityIdentifier = "RepositoryDetailView.WatchLabel"
        forksCountLabel.accessibilityIdentifier = "RepositoryDetailView.ForkLabel"
        openIssueCountLabel.accessibilityIdentifier = "RepositoryDetailView.IssueLabel"
    }
}
