//
//  ComicListPresenter.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal protocol ComicListPresenterProtocol: class {
    func loadView()
    func didSelect(comic: Comic)
   // func fetchNewComicList(startsWith: String?)
    func fetchComicList(startsWith: String?)
    var currentComicList: ComicList { get }
    var view: ComicListViewProtocol? { get set }
}

internal final class ComicListPresenter: ComicListPresenterProtocol {
    
    // MARK: - Properties
    private let comicListRepository: ComicListRepositoryProtocol
    private let comicDetailNavigator: ComicDetailNavigatorProtocol

    // MARK: - Variables
    weak var view: ComicListViewProtocol?
    private var comicListCached = [String?: ComicList]()
    private var prefix: String?
    internal var currentComicList: ComicList {
        if let currentComicList = comicListCached[prefix] {
            return currentComicList
        } else {
            comicListCached[prefix] = ComicList()
            return comicListCached[prefix]!
        }
    }

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
    
    func fetchComicList(startsWith: String? = nil) {
        
        // Check if new filter and case cached
        if startsWith != prefix  && comicListCached[startsWith] != nil {
            prefix = startsWith
            self.view?.update()
            return
        }
        
        prefix = startsWith
        if comicListCached[startsWith] == nil {
            comicListCached[startsWith] = ComicList()
        }
        guard let comicList = comicListCached[startsWith] else { return }
        
        view?.setLoading(true)

        comicListRepository.fetchComicList(offset: comicList.offset, titleStartsWith: startsWith) { [weak self] result in

            guard let `self` = self else { return }
            self.view?.setLoading(false)
            switch result {
            case .success(let newComicList):
                self.comicListCached[startsWith]?.offset = newComicList.offset
                self.comicListCached[startsWith]?.totalItems = newComicList.totalItems
                self.comicListCached[startsWith]?.list.append(contentsOf: newComicList.list)

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
