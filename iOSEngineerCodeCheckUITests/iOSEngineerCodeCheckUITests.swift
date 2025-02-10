//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {
    
    private let app: XCUIApplication = .init()
    
    var searchBar: XCUIElement {
        app.searchFields.element(matching: .searchField, identifier: "RepositorySearchView.SearchBar.SearchTextField")
    }
    
    var searchTableView: XCUIElement {
        app.tables.element(matching: .table, identifier: "RepositorySearchView.SearchTableView")
    }
    
    var searchKeyboardButton: XCUIElement {
        if app.keyboards.firstMatch.buttons.element(matching: .button, identifier: "Search").waitForExistence(timeout: 1) {
            app.keyboards.firstMatch.buttons.element(matching: .button, identifier: "Search")
        } else {
            app.keyboards.firstMatch.buttons.element(matching: .button, identifier: "検索")
        }
    }
    
    
    var detailAvatorImageView: XCUIElement {
        app.images.element(matching: .image, identifier: "RepositoryDetailView.AvatarImageView")
    }
    
    var detailRepositoryNameLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.RepositoryNameLabel")
    }
    
    var detailLanguageLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.LanguageLabel")
    }
    
    var detailStarLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.StarLabel")
    }
    
    var detailWatchLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.WatchLabel")
    }
    
    var detailForkLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.ForkLabel")
    }
    
    var detailIssueLabel: XCUIElement {
        app.staticTexts.element(matching: .staticText, identifier: "RepositoryDetailView.IssueLabel")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testSearchViewInit() throws {
        app.launch()
        XCTAssert(searchBar.exists)
        XCTAssert(searchBar.placeholderValue == "GitHubのリポジトリを検索できます")
        XCTAssert(searchTableView.exists)
    }
    
    func testSearchRepository() throws {
        app.launch()
        searchBar.tap()
        searchBar.typeText("swift")
        searchKeyboardButton.tap()
        sleep(3)
        XCTAssert(searchTableView.cells.count > 0)
        searchTableView.cells.element(boundBy: 0).tap()
    }
    
    func testDetailRepository() throws {
        try testSearchRepository()
        sleep(1)
        XCTAssert(detailAvatorImageView.exists)
        XCTAssert(detailRepositoryNameLabel.exists)
        XCTAssert(detailLanguageLabel.exists)
        XCTAssert(detailStarLabel.exists)
        XCTAssert(detailWatchLabel.exists)
        XCTAssert(detailForkLabel.exists)
        XCTAssert(detailIssueLabel.exists)
    }

}
