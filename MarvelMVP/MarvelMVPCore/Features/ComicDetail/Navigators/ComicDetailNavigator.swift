//
//  ComicDetailNavigator.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import UIKit

internal protocol ComicDetailNavigatorProtocol {
    func showDetail<T>(item: T)
}

internal final class ComicDetailNavigator: ComicDetailNavigatorProtocol {

    // MARK: - Properties
    private let navigationController: UINavigationController
    private unowned let viewControllerProvider: ComicDetailViewControllerProviderProtocol

    init(navigationController: UINavigationController, viewControllerProvider: ComicDetailViewControllerProviderProtocol) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }

    // MARK: - DetailNavigator
    func showDetail<T>(item: T) {

        if let viewController = viewControllerProvider.comicDetailViewController(item: item) {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
