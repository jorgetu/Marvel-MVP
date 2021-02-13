//
//  ComicListBindingTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class ComicListBindingTests: XCTestCase {

    func test_binding() {
        
        let thumbnail = ThumbnailElement(path: "http://www.example.com/image", ext: "jpg")
        
        let date = DateElement(type: "onsaleDate", date: "2029-12-31T00:00:00-0500")
        
        let price = PriceElement(type: "printPrice", price: 42.25)
        
        let element = Element(id: nil, digitalID: nil, title: "Title", thumbnail: thumbnail, pageCount: 100, dates: [date], prices: [price], issueNumber: 10, description: "Description", format: "Comic")
        
        let dataClass = DataClass(offset: 0, limit: 30, total: 100, count: 20, results: [element])
        
        let comicListServiceResponse = ComicListServiceResponse(code: nil, status: nil, copyright: nil, attributionText: nil, attributionHTML: nil, etag: nil, data: dataClass)

        let comicList = ComicListBinding.bind(comicListServiceResponse)
        
        XCTAssertEqual(comicList.list.count, 1)
        XCTAssertEqual(comicList.totalItems,100)
        XCTAssertEqual(comicList.offset,20)
        
        let list = comicList.list[0]
        XCTAssertEqual(list.title, "Title")
        XCTAssertEqual(list.printPrice, 42.25)
        XCTAssertEqual(list.onSaleDate, "2029-12-31T00:00:00-0500")
        XCTAssertEqual(list.thumbnail, URL(string: "http://www.example.com/image.jpg"))
    }

}
