//
//  ReusableCellTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest

class ReusableCellTests: XCTestCase {

    func testReuseIdentifier() {

        let reuseIdentifier = TestCell.reuseIdentifier
        XCTAssertEqual(reuseIdentifier, "TestCell")
    }
}
