//
//  RepositoryDetailTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import XCTest
import Combine
@testable import iOSEngineerCodeCheck

final class RepositoryDetailTest: XCTestCase {
    
    lazy var mockRepository1 = Repository(
        id: 0,
        name: "mock",
        fullName: "mock repo",
        owner: mockOwner1,
        language: "Swift",
        repositoryURL: URL(string: "https://github.com/sugimamo/yumemi-ios-code-check")!,
        stargazersCount: 1,
        watchersCount: 2,
        forksCount: 3,
        openIssuesCount: 4
    )
    lazy var mockRepository2 = Repository(
        id: 0,
        name: "mock",
        fullName: "mock repo",
        owner: mockOwner2,
        language: "Swift",
        repositoryURL: URL(string: "https://github.com/sugimamo/yumemi-ios-code-check")!,
        stargazersCount: 1,
        watchersCount: 2,
        forksCount: 3,
        openIssuesCount: 4
    )
    
    let mockOwner1 = RepositoryOwner(
        id: 0,
        name: "sugimamo",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/25583271?v=4")!
    )
    let mockOwner2 = RepositoryOwner(
        id: 0,
        name: "sugimamo",
        avatarUrl: URL(string: "https://github.com")!
    )

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadAvatarImage() async throws {
        let avatarImageModel = AvatarImageModel()
        var image1: UIImage? = nil
        let cancellable1 = avatarImageModel.loadedImageNotice
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                image1 = image
            })
        await avatarImageModel.loadAvatarImage(url: mockOwner1.avatarUrl)
        sleep(3)
        cancellable1.cancel()
        XCTAssertNotNil(image1)
        
        var image2: UIImage? = nil
        let cancellable2 = avatarImageModel.loadedImageNotice
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                image2 = image
            })
        await avatarImageModel.loadAvatarImage(url: mockOwner2.avatarUrl)
        sleep(3)
        cancellable2.cancel()
        XCTAssertNil(image2)
    }

}
