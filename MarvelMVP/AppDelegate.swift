//
//  AppDelegate.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    let appAssembly = AppAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let initialViewController = appAssembly.coreAssembly.comicListAssembly.viewController()

        appAssembly.navigationController.pushViewController(initialViewController,
                                                            animated: false)

        appAssembly.window.rootViewController = appAssembly.navigationController

        appAssembly.window.makeKeyAndVisible()

        return true
    }
}
