//
//  ComicListAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

public final class ComicListAssembly {

    // MARK: - Properties
    private let comicDetailAssembly: ComicDetailAssembly
    private let webServiceAssembly: WebServiceAssembly

    // MARK: - Initializers
    init(comicDetailAssembly: ComicDetailAssembly,
         webServiceAssembly: WebServiceAssembly) {
        self.comicDetailAssembly = comicDetailAssembly
        self.webServiceAssembly = webServiceAssembly
    }

    // MARK: - Public Methods
    public func viewController() -> UIViewController {

        return ComicListViewController(presenter: presenter())
    }

    // MARK: - Internal Methods
    func presenter() -> ComicListPresenterProtocol {

        return ComicListPresenter(comicDetailNavigator: comicDetailAssembly.detailNavigator(),
                                        comicListRepository: comicListRepository())
    }

    func comicListRepository() -> ComicListRepositoryProtocol {

        return ComicListRepository(webService: webServiceAssembly.webService)
    }
}


