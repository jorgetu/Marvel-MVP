//
//  ComicList.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

// MARK: - Model
struct ComicList {
    var list: [Comic] = []
}

struct Comic {
    let name: String
    let thumbnail : URL?
    let price: Double?
    let releaseDate: String?
}


// MARK: - Service Model
struct ComicListServiceResponse: Decodable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let offset, limit, total, count: Int?
    let results: [Element]?
}

// MARK: - Element
struct Element: Decodable {
    let id, digitalID: Int?
    let title: String?
    let thumbnail: ThumbnailElement?
    let pageCount: Int?
    let dates: [DateElement]?
    let prices: [PriceElement]?

    private enum CodingKeys: String, CodingKey {
        case id
        case digitalID
        case title
        case thumbnail
        case pageCount
        case dates
        case prices
    }
}

// MARK: - ThumbnailElement
struct ThumbnailElement: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    var fullName: String? {
        get {
            if let path = path, let ext = ext {
                return path + "." + ext
            }else{
                return nil
            }
        }
    }
}

// MARK: - DateElement
struct DateElement: Decodable {
    let type: String?
    let date: String?
}

// MARK: - Price
struct PriceElement: Decodable {
    let type: String?
    let price: Double?
}


// MARK: - Binding class
internal final class ComicListBinding {

    static func bind(_ apiComicList: ComicListServiceResponse) -> ComicList {

        var list: [Comic] = []

        apiComicList.data?.results?.forEach { apiComic in

            let name = apiComic.title!
            var url : URL?
            if let thumbnail = apiComic.thumbnail, let fullName = thumbnail.fullName{
                url = URL(string: fullName)
            }
            
            let price = apiComic.prices?.filter({$0.type == "printPrice"}).first?.price
            let onSaleDate = apiComic.dates?.filter({$0.type == "onsaleDate"}).first?.date
            
            let comic = Comic(name: name, thumbnail: url, price: price, releaseDate: onSaleDate)
            list.append(comic)
        }

        return ComicList(list: list)
    }
}

