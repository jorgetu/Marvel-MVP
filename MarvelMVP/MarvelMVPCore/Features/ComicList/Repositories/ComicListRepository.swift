//
//  ComicListRepository.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal protocol ComicListRepositoryProtocol {
    func fetchComicList(offset: Int, titleStartsWith: String?, completion completed: @escaping (Result<ComicList, ServiceError>) -> Void)
}
