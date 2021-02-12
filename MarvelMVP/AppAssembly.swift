//
//  AppAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

internal final class AppAssembly {

    // MARK: - Variables
    private(set) lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var coreAssembly = CoreAssembly(navigationController: navigationController)
    private(set) lazy var navigationController: UINavigationController = {
        return MNavigationController()
    }()
}
