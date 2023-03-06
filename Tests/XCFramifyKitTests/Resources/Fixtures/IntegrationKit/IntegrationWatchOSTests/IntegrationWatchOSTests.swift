//
//  IntegrationWatchOSTests.swift
//  IntegrationWatchOSTests
//
//  Created by Khoa Le on 07/03/2023.
//

import XCTest
@testable import IntegrationWatchOS

final class IntegrationWatchOSTests: XCTestCase {
    var sut: IntegrationWatchOSKit!

    override func setUp() {
        super.setUp()
        sut = IntegrationWatchOSKit()
    }

    func testIntegrationWatchOSShouldCall() {
        XCTAssertEqual(sut.integrationWatchOSShouldCall(), "IntegrationWatchOSShouldCall")
    }
    
}
