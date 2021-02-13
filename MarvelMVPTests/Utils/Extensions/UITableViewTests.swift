//
//  UITableViewTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class UITableViewTests: XCTestCase {

    // MARK: - Variables
    var tableView: UITableView!

    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()

        tableView = UITableView()
    }

    // MARK: - Tests
    func test_dequeueReusableCell() {

        tableView.register(TestCell.self)
        let registeredCell = tableView.dequeueReusableCell(TestCell.self)
        XCTAssertNotNil(registeredCell)
    }

    func test_dequeueReusableCell_indexPath() {

        tableView.register(TestCell.self)
        let registeredCell = tableView.dequeueReusableCell(TestCell.self, for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(registeredCell)
    }
}
