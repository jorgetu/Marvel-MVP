//
//  ComicListPresenterTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP


// MARK: - ComicListViewMock
class ComicListViewMock: ComicListViewProtocol {

    private(set) var startLoadingCalled = false
    private(set) var stopLoadingCalled = false
    private(set) var updateComicsCalled = false
    private(set) var showErrorCalled = false
    
    var title: String?
    
    var isFilterEmpty: Bool = false

    func setLoading(_ loading: Bool) {
        if loading { startLoadingCalled = true } else { stopLoadingCalled = true }
    }

    func update() {
        updateComicsCalled = true
    }

    func showError(_ error: ServiceError) {
        showErrorCalled = true
    }
}

// MARK: - ComicListRepositoryMock
class ComicListRepositoryMock: ComicListRepositoryProtocol {

    var forceError = false

    func fetchComicList(offset: Int, titleStartsWith: String?, completion completed: @escaping (Result<ComicList, ServiceError>) -> Void) {
        
        let comic = Comic(title: "Title One", issueNumber: 1, description: "Description", format: .comic, pageCount: 200, thumbnail: URL(string: "http://www.example.com/image.jpg"), printPrice: 30.0, digitalPrice: 20.0, onSaleDate: "28/12/2020")
        
        let comicList = ComicList(list: [comic], totalItems: 100, offset: 40)
        
        let serviceError = ServiceError.unexpected

        _ = forceError ? completed(.failure(serviceError)) : completed(.success(comicList))
    }
}

// MARK: - DetailNavigatorMock
class ComicDetailNavigatorMock: ComicDetailNavigatorProtocol {

    private(set) var showDetailCalled = false

    func showDetail<T>(item: T) {
        showDetailCalled = true
    }
}

class ComicListPresenterTests: XCTestCase {

    // MARK: - Variables
    private var repository: ComicListRepositoryMock!
    private var view: ComicListViewMock!
    private var detailNavigator: ComicDetailNavigatorMock!
    private var presenter: ComicListPresenter!

    // MARK: - Tests
    func test_loadView() {

        // Given
        repository = ComicListRepositoryMock()
        repository.forceError = false
        view = ComicListViewMock()
        detailNavigator = ComicDetailNavigatorMock()
        presenter = ComicListPresenter(comicDetailNavigator: detailNavigator, comicListRepository: repository)
        presenter.view = view

        // When
        presenter.loadView()

        // Then
        XCTAssertEqual(view.title, "Marvel")
        XCTAssertTrue(view.startLoadingCalled)
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertTrue(view.updateComicsCalled)
    }


    func test_fetchComic_fail() {

        // Given
        repository = ComicListRepositoryMock()
        repository.forceError = true
        view = ComicListViewMock()
        detailNavigator = ComicDetailNavigatorMock()
        presenter = ComicListPresenter(comicDetailNavigator: detailNavigator, comicListRepository: repository)
        presenter.view = view


        // When
        presenter.fetchComicList()

        // Then
        XCTAssertTrue(view.startLoadingCalled)
        XCTAssertTrue(view.stopLoadingCalled)
        XCTAssertTrue(view.showErrorCalled)
    }

    func test_didSelect() {

        // Given
        repository = ComicListRepositoryMock()
        repository.forceError = false
        view = ComicListViewMock()
        detailNavigator = ComicDetailNavigatorMock()
        presenter = ComicListPresenter(comicDetailNavigator: detailNavigator, comicListRepository: repository)
        presenter.view = view
        
        let comic = Comic(title: "Title One", issueNumber: 1, description: "Description", format: .comic, pageCount: 200, thumbnail: URL(string: "http://www.example.com/image.jpg"), printPrice: 30.0, digitalPrice: 20.0, onSaleDate: "28/12/2020")

        // When
        presenter.didSelect(comic: comic)

        // Then
        XCTAssertTrue(detailNavigator.showDetailCalled)
    }

}
