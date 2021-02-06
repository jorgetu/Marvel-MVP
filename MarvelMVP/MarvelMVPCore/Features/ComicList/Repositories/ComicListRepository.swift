//
//  ComicListRepository.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal protocol ComicListRepositoryProtocol {
    func fetchComicList(completion completed: @escaping (Result<ComicList, ServiceError>) -> Void)
}


internal final class ComicListRepository: ComicListRepositoryProtocol {

    // MARK: - Properties
    private let webService: WebService
    private var isFetchInProgress = false

    // MARK: - Initializers
    init(webService: WebService) {
        self.webService = webService
    }

    // MARK: - ComicListRepository
    func fetchComicList(completion completed: @escaping (Result<ComicList, ServiceError>) -> Void) {
        
        webService.load(ComicListServiceResponse.self, from: .comics) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let apiComicList):
                                    let comicList = ComicListBinding.bind(apiComicList)
                                    completed(.success(comicList))
                                case .failure(let error):
                                    completed(.failure(error))
                                }
                            }
        }
    }
}
