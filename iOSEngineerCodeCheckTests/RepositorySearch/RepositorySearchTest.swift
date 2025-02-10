//
//  RepositorySearchTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class RepositorySearchTest: XCTestCase {
    
    let viewModel = RepositorySearchViewModel()
    
    var viewController: RepositorySearchViewController!

    override func setUpWithError() throws {
        if viewController == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewController(
                identifier: "RepositorySearchViewController",
                creator: { coder in
                    return RepositorySearchViewController(coder: coder)
                }
            )
        }
        viewController.loadView()
        viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchRepository() throws {
        viewModel.searchRepository(with: "")
        sleep(3)
        XCTAssert(viewModel.repositories.isEmpty)
        
        viewModel.searchRepository(with: "swift")
        sleep(3)
        XCTAssert(!viewModel.repositories.isEmpty)
    }
    
    func testSelectIndex() throws {
        XCTAssertNil(viewModel.selectedIndex)
        let idx0 = 0
        viewModel.setSelectedIndex(to: idx0)
        XCTAssert(viewModel.selectedIndex == idx0)
    }
    
    func testTappedCell() throws {
        viewController.repositorySearchBar.text = "swift"
        viewController.searchBarSearchButtonClicked(viewController.repositorySearchBar)
        sleep(3)
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)
        XCTAssertNotNil(viewController.viewModel.selectedIndex)
    }
}
