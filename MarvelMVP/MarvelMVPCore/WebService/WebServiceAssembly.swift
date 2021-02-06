//
//  WebServiceAssembly.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

public final class WebServiceAssembly {

    // MARK: - Variables
    private(set) lazy var webService = WebService(session: URLSession(configuration: .default))

    // MARK: - Initializers
    public init() {}
}
