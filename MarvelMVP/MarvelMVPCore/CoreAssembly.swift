//
//  CoreAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

final public class CoreAssembly {

    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Variables
    public private(set) lazy var comicListAssembly =
        ComicListAssembly(comicDetailAssembly: comicDetailAssembly,
                                webServiceAssembly: webServiceAssembly)
    private(set) lazy var comicDetailAssembly = ComicDetailAssembly(navigationController: navigationController)
    private(set) lazy var webServiceAssembly = WebServiceAssembly()

    // MARK: - Initializers
    public init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }
}
