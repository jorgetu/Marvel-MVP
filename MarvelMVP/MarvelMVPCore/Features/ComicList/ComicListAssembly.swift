//
//  ComicListAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

public final class ComicListAssembly {

    // MARK: - Properties
    private let webServiceAssembly: WebServiceAssembly

    // MARK: - Initializers
    init(webServiceAssembly: WebServiceAssembly) {
        self.webServiceAssembly = webServiceAssembly
    }

    // MARK: - Public Methods
    public func viewController() -> UIViewController {
        return ComicListViewController(presenter: presenter())
    }

    // MARK: - Internal Methods
    func presenter() -> ComicListPresenterProtocol {
        return ComicListPresenter(comicListRepository: comicListRepository())
    }

    func comicListRepository() -> ComicListRepositoryProtocol {
        return ComicListRepository(webService: webServiceAssembly.webService)
    }
}

