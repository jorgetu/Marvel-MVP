//
//  NibLoadableViewTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest



class NibLoadableViewTests: XCTestCase {

    func testNibName() {

        let testCellNibName = TestCell.nibName
        XCTAssertEqual(testCellNibName, "TestCell")
    }

    func testInstantiate() {

        let testCell = TestCell.instantiate()
        XCTAssertNotNil(testCell)
    }
}
