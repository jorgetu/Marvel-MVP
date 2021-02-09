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
