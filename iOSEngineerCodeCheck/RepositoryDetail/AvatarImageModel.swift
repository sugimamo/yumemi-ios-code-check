//
//  AvatarImageModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import Combine

struct AvatarImageModel {
    /// 画像ロード後Viewへ通知する
    let loadedImageNotice: PassthroughSubject<UIImage, Never> = .init()
    
    /// アバターの画像をロードする。
    func loadAvatarImage(url: URL) async {
        do {
            print("loadAvatarImage")
            let avatarImage = try await load(url: url.description)
            print("loaded")
            loadedImageNotice.send(avatarImage)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension AvatarImageModel: APIClient {
    typealias ResponseData = UIImage
    
    func decode(from data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw APIError.notImageData
        }
        return image
    }
}
