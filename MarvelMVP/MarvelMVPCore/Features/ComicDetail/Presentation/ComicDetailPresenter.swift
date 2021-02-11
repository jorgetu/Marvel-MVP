//
//  ComicDetailPresenter.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import Foundation



internal protocol ComicDetailPresenterProtocol: class {

    var view: ComicDetailViewProtocol? { get set }
    func loadView()
}

internal final class ComicDetailPresenter: ComicDetailPresenterProtocol {

    // MARK: - Properties
    private let comic: Comic
 
    // MARK: - Variables
    weak var view: ComicDetailViewProtocol?

    // MARK: - Initializers
    init(comic: Comic) {
        self.comic = comic
    }

    // MARK: - ComicDetailPresenterProtocol
    func loadView() {

        view?.title = "comicList_detail".localized
        view?.showComic(comic: self.comic)
    }
}
