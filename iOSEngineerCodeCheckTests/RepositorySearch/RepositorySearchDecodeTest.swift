//
//  RepositorySearchDecodeTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class RepositorySearchDecodeTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeResponse() throws {
        let apiclient = RepositorySearchAPI()
        do {
            let searchRepository1 = try apiclient.decode(from: mockRepositorySearchJson.data(using: .utf8)!)
            XCTAssertNotNil(searchRepository1)
        } catch {
            XCTAssertNil(error)
        }
        do {
            let searchRepository2 = try apiclient.decode(from: "None Data".data(using: .utf8)!)
            XCTAssertNil(searchRepository2)
        } catch {
            XCTAssertNotNil(error)
        }
            
    }
    

}
