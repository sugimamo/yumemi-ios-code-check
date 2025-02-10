//
//  RepositoryDetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/09.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine
import UIKit

class RepositoryDetailViewModel: ObservableObject {
    /// リポジトリ情報
    let repository: Repository
    /// アバター画像
    let avatarImageModel: AvatarImageModel = .init()
    
    init(repository: Repository) {
        self.repository = repository
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            await self.avatarImageModel.loadAvatarImage(url: repository.owner.avatarUrl)
        }
    }
    
    func openRepositoryUrl() {
        UIApplication.shared.open(repository.repositoryURL)
    }
    
    func getShareItems() -> [Any] {
        return [repository.repositoryURL]
    }
}

