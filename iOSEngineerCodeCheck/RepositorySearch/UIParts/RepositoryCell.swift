//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watchCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!
    
    func setupCell(repository: Repository) {
        nameLabel.text = repository.fullName
        starCountLabel.text = "\(repository.stargazersCount)"
        watchCountLabel.text = "\(repository.watchersCount)"
        forkCountLabel.text = "\(repository.forksCount)"
        issueCountLabel.text = "\(repository.openIssuesCount)"
        setCornerRadius()
        setShadow()
        setAccessibilityId()
    }
    
    func setCornerRadius() {
        mainView.layer.cornerRadius = 10
    }
    
    func setShadow() {
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOpacity = 0.6
        mainView.layer.shadowRadius = 4
    }
    
    func setAccessibilityId() {
        nameLabel.accessibilityIdentifier = "RepositoryCell.NameLabel"
        starCountLabel.accessibilityIdentifier = "RepositoryCell.StarLabel"
        watchCountLabel.accessibilityIdentifier = "RepositoryCell.WatchLabel"
        forkCountLabel.accessibilityIdentifier = "RepositoryCell.ForkLabel"
        issueCountLabel.accessibilityIdentifier = "RepositoryCell.IssueLabel"
    }
}

    
