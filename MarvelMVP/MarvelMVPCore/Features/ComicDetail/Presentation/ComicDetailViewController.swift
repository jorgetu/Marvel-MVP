//
//  ComicDetailViewController.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import UIKit

protocol ComicDetailViewControllerProviderProtocol: class {
    func comicDetailViewController<T>(item: T) -> UIViewController?
}

internal protocol ComicDetailViewProtocol: class {
    var title: String? { get set }
    func showComic(comicName: String)
}


