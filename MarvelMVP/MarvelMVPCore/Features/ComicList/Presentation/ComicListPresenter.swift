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
    func didSelect(comic: Comic)
    var comicList : ComicList { get }
    var view: ComicListViewProtocol? { get set }
}

internal final class ComicListPresenter: ComicListPresenterProtocol {
    

    // MARK: - Properties
    private let comicListRepository  : ComicListRepositoryProtocol
    private let comicDetailNavigator: ComicDetailNavigatorProtocol

    // MARK: - Variables
    weak var view: ComicListViewProtocol?
    internal var comicList = ComicList()

    // MARK: - Initializers
    init(comicDetailNavigator: ComicDetailNavigatorProtocol,
         comicListRepository: ComicListRepositoryProtocol) {
        self.comicDetailNavigator = comicDetailNavigator
        self.comicListRepository = comicListRepository
    }

    // MARK: - ComicListPresenterProtocol
    func loadView() {
        view?.title = "comicList_title".localized
        fetchComicList()
    }
    
    func fetchComicList() {
        
        view?.setLoading(true)

        comicListRepository.fetchComicList(offset: self.comicList.offset) { [weak self] result in

            guard let `self` = self else { return }
            self.view?.setLoading(false)
            switch result {
            case .success(let newComicList):
                self.comicList.offset = newComicList.offset
                self.comicList.totalItems = newComicList.totalItems
                self.comicList.list.append(contentsOf: newComicList.list)

                self.view?.update()
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func didSelect(comic: Comic) {
        comicDetailNavigator.showDetail(item: comic)
    }
}
