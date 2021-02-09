//
//  ComicDetailAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import Foundation
import UIKit

internal final class ComicDetailAssembly {

    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Initializers
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Internal Methods
    func comicDetailPresenter(comicName: String) -> ComicDetailPresenterProtocol {

        return ComicDetailPresenter(comicName: comicName)
    }

    func detailNavigator() -> ComicDetailNavigatorProtocol {

        return ComicDetailNavigator(navigationController: navigationController, viewControllerProvider: self)
    }
}

// MARK: - DetailViewControllerProvider
extension ComicDetailAssembly: ComicDetailViewControllerProviderProtocol {

    func comicDetailViewController<T>(item: T) -> UIViewController? {

        var viewController: UIViewController?

        if let comic = item as? Comic {
            let presenter = ComicDetailPresenter(comicName: comic.name)
            viewController = ComicDetailViewController(presenter: presenter)
        }
       

        return viewController
    }
}

