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
    @Published var avatarImage: UIImage? = nil
    
    init(repository: Repository) {
        self.repository = repository
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            self.avatarImage = await getAvatorImage(for: repository.owner.avatarUrl)
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
