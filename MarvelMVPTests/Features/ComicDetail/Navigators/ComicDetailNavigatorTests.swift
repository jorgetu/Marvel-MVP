//
//  ComicDetailNavigatorTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class ComicDetailViewControllerProviderMock: ComicDetailViewControllerProviderProtocol {

    func comicDetailViewController<T>(item: T) -> UIViewController? {
        guard let comic = item as? Comic else { return nil }
        let presenter = ComicDetailPresenter(comic: comic)
        return ComicDetailViewController(presenter: presenter)
    }
}


class ComicDetailNavigatorTests: XCTestCase {
    // MARK: - Variables
    private var navigationController: UINavigationController!
    private var viewControllerProvider: ComicDetailViewControllerProviderMock!
    private var navigator: ComicDetailNavigator!

    func test_showDetail() {

        // Given
        navigationController = UINavigationController()
        viewControllerProvider = ComicDetailViewControllerProviderMock()
        navigator = ComicDetailNavigator(navigationController: navigationController,
                                         viewControllerProvider: viewControllerProvider)

        // When
        let comic = Comic(title: "Title One", issueNumber: 1, description: "Description", format: .comic, pageCount: 200, thumbnail: URL(string: "http://www.example.com/image.jpg"), printPrice: 30.0, digitalPrice: 20.0, onSaleDate: "28/12/2020")
        navigator.showDetail(item: comic)

        // Then
        XCTAssertTrue(navigationController.visibleViewController is ComicDetailViewController)
    }
}
