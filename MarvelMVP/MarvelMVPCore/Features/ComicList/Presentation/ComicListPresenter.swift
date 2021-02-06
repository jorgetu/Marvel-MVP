//
//  ComicListPresenter.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal protocol ComicListPresenterProtocol: class {
    func loadView()
    func fetchComicList()
    var comicList : ComicList { get }
    var view: ComicListViewProtocol? { get set }
}

internal final class ComicListPresenter: ComicListPresenterProtocol {
    

    // MARK: - Properties
    private let comicListRepository  : ComicListRepositoryProtocol

    // MARK: - Variables
    weak var view: ComicListViewProtocol?
    internal var comicList = ComicList()

    // MARK: - Initializers
    init(comicListRepository: ComicListRepositoryProtocol) {
        self.comicListRepository = comicListRepository
    }

    // MARK: - ComicListPresenterProtocol
    func loadView() {
        fetchComicList()
    }
    
    func fetchComicList() {
        
        view?.setLoading(true)

        comicListRepository.fetchComicList() { [weak self] result in

            guard let `self` = self else { return }
            self.view?.setLoading(false)
            switch result {
            case .success(let newComicList):
                self.comicList = newComicList

                self.view?.update()
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
}
