//
//  ComicListPresenter.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal protocol ComicListViewProtocol: class {
    func setLoading(_ loading: Bool)
    func update()
    func showError(_ error: ServiceError)
}
